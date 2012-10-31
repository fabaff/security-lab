#!/usr/bin/python
#
# security-lab-maintenance - A helper script to maintain the Security Lab package
# list and other relevant maintenance task.
#
# Copyright (c) 2012 Fabian Affolter <fab@fedoraproject.org>
#
# All rights reserved.
# 
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc.,
# 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
#
# Credits goes to Robert Scheck. He did a lot brain work for the initial
# approach. This script is heavy based on his perl scripts.

import argparse
import operator
import itertools
import re
import sys
import os
import yum
import yaml

def getPackages():
    """
    Reading yaml package file which is placed in the root of the Fedora 
    Security Lab git repository.
    """
    file = open("pkglist.yaml", "r") 
    pkgslist = yaml.safe_load(file)
    file.close()
    return pkgslist

def display():
    """All included tools and details will be printed to STDOUT."""
    pkgslist = getPackages()

    # Split list of packages into eincluded and excluded packages
    pkgslistIn = []
    pkgslistEx = []
    for pkg in pkgslist:
	    if 'exclude' in pkg:
	        pkgslistEx.append(pkg['pkg'])
	    else:
	        pkgslistIn.append(pkg['pkg'])

    # Displays the details to STDOUT
    print '\nDetails about the packages in the Fedora Security Lab\n'
    print 'Total entries: %s' % len(pkgslist)
    print 'Included packages: %s' % len(pkgslistIn)
    print 'Excluded packages: %s\n' % len(pkgslistEx)
    print 'Package list:'
    sorted_pkgslist = sorted(pkgslistIn)
    for pkg in sorted_pkgslist:
        print pkg

def add(pkgname):
    """Adds a new package to the Fedora Security Lab."""
    print 'Not implemented at the moment. Package name was %s. Please edit ' \
          'the pkglist.yaml file by hand.' % pkgname

def edit(pkgname):
    """Modify an existing package in the package list."""
    print 'Not implemented at the moment. Package name was %s. Please edit ' \
          'the pkglist.yaml file by hand.' % pkgname

def comps():
    """
    Generates the entries to include into the comps-fXX.xml.in file.  
    <packagelist>
      ...
    </packagelist>
    """
    pkgslist = getPackages()

    # Split list of packages into eincluded and excluded packages
    sorted_pkgslist = sorted(pkgslist, key=operator.itemgetter('pkg'))
    for pkg in sorted_pkgslist:
	    if 'exclude' in pkg:
	        pass
	    else:
	        print '      <packagereq type="default">%s</packagereq>' % pkg['pkg']

def trac():
    """Generates the package overview for FSL trac instance."""
    pkgslist = getPackages()

    # Simplifiy the packages list, only package name and category are relevant
    # for the Trac wiki page
    pkgslistIn = []
    for pkg in pkgslist:
	    pkgslistIn.append((pkg['pkg'], pkg['category']))

    sorted_pkgslist = sorted(pkgslistIn, key=operator.itemgetter(1))
    groups = itertools.groupby(sorted_pkgslist, key=operator.itemgetter(1))
    sorted_categories = [{'category': k, 'pkgs': [x[0] for x in v]} for k, v in groups]
    print sorted_categories


    yb = yum.YumBase()
    yb.conf.cache = 0
    print '<--- snip --->'
    for cat in sorted_categories:
        if cat['category'] != 'VoIP':
            elements = re.findall('[A-Z][^A-Z]*', cat['category'])
            category_name = ' '.join(elements)
        else:
            category_name = cat['category']
        print '== %s ==' % category_name
        for pkg in cat['pkgs']:
            pkgData = yb.pkgSack.searchNevra(pkg)
            for detail in pkgData:
                print detail.name, detail.url
#                part1 = '* [%s %s]' % (detail.url, detail.name)
#                part2 = detail.summary
#                part3 = '[https://admin.fedoraproject.org/pkgdb/packages/name/%s Fedora Package Database]' % detail.name
#                part4 = '[https://admin.fedoraproject.org/pkgdb/acls/bugs/%s Bug Reports]' % detail.name
#                entry =  part1 + " - " + part2 + " - " + part3 + " - " + part4
#                print entry
    print '<--- snap --->\nPlease copy the text between the markings to the '
    print 'availableApps page in the Trac wiki.'

def menus():
    """
    Generator for the .desktop files which are used for the menu structure.
    All files are packaged in the security-menus RPM package.
    """
    pkgslist = getPackages()
    # Terminal is the standard terminal application of the Xfce desktop
    terminal = 'Terminal'

    # Collects all files in the directory
    filelist = []
    os.chdir('/security-menu')
    for files in os.listdir("."):
        if files.endswith(".desktop"):
            filelist.append(files)

    # Write .desktop files
    for pkg in pkgslist:
        if 'command' in pkg:
	        fileOut = open('security-' + pkg['pkg'] + '.desktop','w')
	        fileOut.write('[Desktop Entry]\n')
	        fileOut.write('Name=%s\n' %  pkg['name'])
	        fileOut.write("Exec=%s -e \"su -c '%s; bash'\"\n" % (terminal, pkg['command']))
	        fileOut.write('TryExec=%s\n' % pkg['pkg'])
	        fileOut.write('Type=Application\n')
	        fileOut.write('Categories=System;Security;X-SecurityLab;X-%s;\n' % pkg['category'])
	        fileOut.close()

    # Compare the needed .desktop file against the included packages, remove
    # .desktop files from exclude packages
    dellist = filelist
    for pkg in pkgslist:
            if 'command' in pkg:
                dellist.remove('security-' + pkg['pkg'] + '.desktop')
            if 'exclude' in pkg:
                if pkg['exclude'] == 1:
                    dellist.append('security-' + pkg['pkg'] + '.desktop')

    # Remove the .desktop files which are no longer needed
    if len(dellist) != 0:
        for file in dellist:
	        os.remove(file)

def argParsing():
    parser = argparse.ArgumentParser(
	    description='This tool can be used for maintaining the Fedora Security Lab package list.',
	    epilog="Please report all bugs and comment.")
    parser.add_argument('-d', '--display',
                        action='store_true',
                        help='display the current included tools to STDOUT')
    parser.add_argument('-a', '--add',
                        help='add a new tool to the Fedora Security Lab')
    parser.add_argument('-e', '--edit',
                       help='editing a given entry')
    parser.add_argument('-c', '--comps',
                       action='store_true',
                       help='generates a package list for comps')
    parser.add_argument('-t', '--trac',
                       action='store_true',
                       help='generate an updated list for the incluction in trac')
    parser.add_argument('-m', '--menus',
                       action='store_true',
                       help='generate an updated list for the security-menus package')
    return parser.parse_args()

if __name__ == '__main__':
    args = argParsing()
    if args.display:
        display()
    if args.add:
        add(args.add)
    if args.edit:
        edit(args.edit)
    if args.comps:
        comps()
    if args.trac:
        trac()
    if args.menus:
        menus()
