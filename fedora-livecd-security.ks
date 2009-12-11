# Filename:
#   fedora-livecd-security.ks
# Description:
#   A fully functional live OS based on Fedora for use in security auditing, forensics research, and penetration testing.
# Maintainers:
#   Luke Macken
#   Adam Miller <maxamillion [AT] fedoraproject.org>
#   Joerg Simon
# Acknowledgements:
#   Fedora LiveCD Xfce Spin team - some work here was inherited, many thanks!

%include fedora-live-base.ks

%packages
-fedora-logos
generic-logos

firefox

midori
cups-pdf
gnome-bluetooth
alsa-plugins-pulseaudio
pavucontrol

# Command line
ntfs-3g
powertop
wget
irssi
mutt
yum-utils
cnetworkmanager

gdm
Thunar 
gtk-xfce-engine
thunar-volman
xarchiver

# dictionaries are big
#-aspell-*
#-man-pages-*

# more fun with space saving
-gimp-help


# save some space
-autofs
-nss_db
-sendmail
ssmtp
-acpid
# system-config-printer does printer management better
# xfprint has now been made as optional in comps.
system-config-printer

###################### Security Stuffs ############################
# Reconnaissance
dsniff
hping3
nc6
nc
nessus-client
nessus-gui
nessus-server
ngrep
nmap
nmap-frontend
p0f
sing
scanssh
scapy
socat
tcpdump
tiger
unicornscan
wireshark-gnome
xprobe2
nbtscan
tcpxtract
firewalk
hunt
halberd
argus
nbtscan
ettercap
ettercap-gtk
iptraf
pcapdiff
picviz
etherape
lynis

# Forensics
chkrootkit
clamav
dd_rescue
gparted
hexedit
prelude-lml
testdisk
foremost
mhonarc
sectool-gui
rkhunter
scanmem
sleuthkit
unhide
examiner
dc3dd

# Wireless
aircrack-ng
airsnort
kismet

# Code analysis
splint
pscan
flawfinder
rats

# Intrusion detection
snort
aide
tripwire
labrea
honeyd
pads
prewikka
prelude-notify
prelude-manager
nebula

# Password cracking
john
ophcrack

# Anonymity
tor

# under review (#461385)
#hydra

# Useful tools
lsof
ntop
scrot
mc

# Other necessary components
yum-fastestmirror
screen
openbox
obconf
obmenu
desktop-backgrounds-basic
feh
vim-enhanced
gnome-menus
gnome-terminal
PolicyKit-gnome

# make sure debuginfo doesn't end up on the live image
-*debuginfo


%end

%post
sed -i -e 's/Fedora/Generic/g' /etc/fedora-release


# create /etc/sysconfig/desktop (needed for installation)

cat >> /etc/sysconfig/desktop <<EOF
PREFERRED=/usr/bin/openbox
EOF

mkdir -p /home/liveuser/.config/openbox

mkdir -p /root/.config/openbox

cat >> /home/liveuser/.config/openbox/autostart.sh << OBDONE

# Run the system-wide support stuff
. /etc/xdg/openbox/autostart.sh

OBDONE

cat >> /etc/rc.d/init.d/livesys << EOF

# rc.xml
cp /etc/xdg/openbox/rc.xml /home/liveuser/.config/openbox
sed -i -e 's/Clearlooks/Onyx/' /home/liveuser/.config/openbox/rc.xml

# menu.xml
cat >> /home/liveuser/.config/openbox/menu.xml << OBDONE
<?xml version="1.0" encoding="UTF-8"?>

<openbox_menu xmlns="http://openbox.org/3.4/menu">

<menu id="recon-menu" label="Reconnaissance">
  <item label="ettercap">
    <action name="Execute"><command>gnome-terminal -e "su -c ettercap-gtk"</command></action>
  </item>
<item label="hping3">
    <action name="Execute"><command>gnome-terminal -e "sh -c 'hping3; bash'"</command></action>
  </item>
  <item label="nc6">
    <action name="Execute"><command>gnome-terminal -e "sh -c 'nc6 -h; bash'"</command></action>
  </item>
  <item label="nc">
    <action name="Execute"><command>gnome-terminal -e "sh -c 'nc; bash'"</command></action>
  </item>
  <item label="ngrep">
    <action name="Execute"><command>gnome-terminal -e "sh -c 'ngrep -h; bash'"</command></action>
  </item>
  <item label="nessus">
    <action name="Execute"><command>gnome-terminal -e "sh -c 'nessus; bash'"</command></action>
  </item>
  <item label="zenmap">
    <action name="Execute"><command>gnome-terminal -e "sh -c 'zenmap-root; bash'"</command></action>
  </item>
  <item label="p0f">
    <action name="Execute"><command>gnome-terminal -e "sh -c 'p0f -h; bash'"</command></action>
  </item>
  <item label="sing">
    <action name="Execute"><command>gnome-terminal -e "sh -c 'sing; bash'"</command></action>
  </item>
  <item label="scanssh">
    <action name="Execute"><command>gnome-terminal -e "sh -c 'scanssh; bash'"</command></action>
  </item>
  <item label="scapy">                                                        
    <action name="Execute"><command>gnome-terminal -e "su -c 'scapy; bash'"</command></action>                                                                
  </item> 
  <item label="socat">
    <action name="Execute"><command>gnome-terminal -e "sh -c 'socat; bash'"</command></action>
  </item>
  <item label="tcpdump">
    <action name="Execute"><command>gnome-terminal -e "sh -c 'tcpdump -h; bash'"</command></action>
  </item>
  <item label="tiger">
    <action name="Execute"><command>gnome-terminal -e "sh -c 'tiger; bash'"</command></action>
  </item>
  <item label="unicornscan">
    <action name="Execute"><command>gnome-terminal -e "sh -c 'unicornscan; bash'"</command></action>
  </item>
  <item label="wireshark">
    <action name="Execute"><command>gnome-terminal -e "sh -c 'wireshark; bash'"</command></action>
  </item>
  <item label="xprobe2">
    <action name="Execute"><command>gnome-terminal -e "sh -c 'xprobe2; bash'"</command></action>
  </item>
  <item label="nbtscan">
    <action name="Execute"><command>gnome-terminal -e "sh -c 'nbtscan; bash'"</command></action>
  </item>
  <item label="tcpxtract">
    <action name="Execute"><command>gnome-terminal -e "sh -c 'tcpxtract; bash'"</command></action>
  </item>
  <item label="firewalk">
    <action name="Execute"><command>gnome-terminal -e "sh -c 'firewalk; bash'"</command></action>
  </item>
  <item label="hunt">
    <action name="Execute"><command>gnome-terminal -e "sh -c 'hunt; bash'"</command></action>
  </item>
  <item label="halberd">
    <action name="Execute"><command>gnome-terminal -e "sh -c 'halberd; bash'"</command></action>
  </item>
  <item label="iptraf">
    <action name="Execute"><command>gnome-terminal -e "sh -c 'iptraf; bash'"</command></action>
  </item>
</menu>

<menu id="forensics-menu" label="Forensics">
  <item label="chkrootkit">
    <action name="Execute"><command>gnome-terminal -e "sh -c 'chkrootkit; bash'"</command></action>
  </item>
  <item label="rkhunter">
    <action name="Execute"><command>gnome-terminal -e "sh -c 'rkhunter; bash'"</command></action>
  </item>
  <item label="clamav">
    <action name="Execute"><command>gnome-terminal -e "sh -c 'clamscan; bash'"</command></action>
  </item>
  <item label="dd_rescue">
    <action name="Execute"><command>gnome-terminal -e "sh -c 'dd_rescue; bash'"</command></action>
  </item>
  <item label="dc3dd">
    <action name="Execute"><command>gnome-terminal -e "sh -c 'dc3dd; bash'"</command></action>
  </item>
  <item label="gparted">
    <action name="Execute"><command>gnome-terminal -e "sh -c 'gparted; bash'"</command></action>
  </item>
  <item label="hexedit">
    <action name="Execute"><command>gnome-terminal -e "sh -c 'hexedit; bash'"</command></action>
  </item>
  <item label="prelude">
    <action name="Execute"><command>gnome-terminal -e "sh -c 'prelude; bash'"</command></action>
  </item>
  <item label="testdisk">
    <action name="Execute"><command>gnome-terminal -e "sh -c 'testdisk; bash'"</command></action>
  </item>
  <item label="foremost">
    <action name="Execute"><command>gnome-terminal -e "sh -c 'foremost; bash'"</command></action>
  </item>
  <item label="mhonarc">
    <action name="Execute"><command>gnome-terminal -e "sh -c 'mhonarc; bash'"</command></action>
  </item>
</menu>

<menu id="wireless-menu" label="Wireless">
  <item label="aircrack-ng">
    <action name="Execute"><command>gnome-terminal -e "sh -c 'aircrack-ng; bash'"</command></action>
  </item>
  <item label="airsnort">
    <action name="Execute"><command>airsnort</command></action>
  </item>
  <item label="kismet">
    <action name="Execute"><command>kismet</command></action>
  </item>
  <item label="dsniff">
    <action name="Execute"><command>dsniff</command></action>
  </item>
</menu>

<menu id="code-menu" label="Code Analysis">
  <item label="pscan">
    <action name="Execute"><command>gnome-terminal -e "sh -c 'pscan; bash'"</command></action>
  </item>
  <item label="splint">
    <action name="Execute"><command>gnome-terminal -e "sh -c 'splint; bash'"</command></action>
  </item>
  <item label="flawfinder">
    <action name="Execute"><command>gnome-terminal -e "sh -c 'flawfinder; bash'"</command></action>
  </item>
  <item label="rats">
    <action name="Execute"><command>gnome-terminal -e "rats; bash'"</command></action>
  </item>
</menu>

<menu id="id-menu" label="Intrusion Detection">
  <item label="aide">
    <action name="Execute"><command>gnome-terminal -e "su -c 'aide; bash'"</command></action>
  </item>
  <item label="snort">
    <action name="Execute"><command>gnome-terminal -e "sh -c 'snort; bash'"</command></action>
  </item>
  <item label="tripwire">
    <action name="Execute"><command>gnome-terminal -e "sh -c 'tripwire --help; bash'"</command></action>
  </item>
  <item label="labrea">
    <action name="Execute"><command>gnome-terminal -e "sh -c 'labrea; bash'"</command></action>
  </item>
</menu>

<menu id="password-menu" label="Password Tools">
  <item label="john">
    <action name="Execute"><command>gnome-terminal -e "sh -c 'john; bash'"</command></action>
  </item>
  <item label="ophcrack">
    <action name="Execute"><command>ophcrack</command></action>
  </item>
</menu>

<menu id="root-menu" label="Fedora Security Spin">
  <separator label="Fedora Security Spin" />
  <menu id="recon-menu" />
  <menu id="forensics-menu" />
  <menu id="wireless-menu" />
  <menu id="id-menu" />
  <menu id="code-menu" />
  <menu id="password-menu" />
  <separator />
  <item label="Terminal">
    <action name="Execute">
      <command>gnome-terminal</command>
    </action>
  </item>
  <item label="Firefox">
    <action name="Execute">
      <command>firefox</command>
    </action>
  </item>
  <item label="Midori">
    <action name="Execute">
      <command>midori</command>
    </action>
  </item>
  <item label="cNetworkManager">
    <action name="Execute"><command>gnome-terminal -e "su -c 'cnetworkmanager -h; bash'"</command></action>
  </item>
  <item label="MidnightCommander">
    <action name="Execute"><command>gnome-terminal -e "su -c 'mc; bash'"</command></action>
  </item>
  <item label="Screenshot">
    <action name="Execute"><command>gnome-terminal -e "su -c 'scrot -h; bash'"</command></action>
  </item>
  <separator />
  <menu id="applications-menu" label="Applications" execute="/usr/share/openbox/xdg-menu applications"/>
  <menu id="preferences-menu" label="Preferences" execute="/usr/share/openbox/xdg-menu preferences"/>
  <menu id="administration-menu" label="Administration" execute="/usr/share/openbox/xdg-menu system-settings"/>
  <item label="Install to Hard Drive">
    <action name="Execute">
      <command>liveinst</command>
    </action>
  </item>
  <separator />
  <menu id="client-list-menu" />
  <separator />
  <item label="ObConf">
    <action name="Execute">
      <startupnotify><enabled>yes</enabled><icon>openbox</icon></startupnotify>
      <command>obconf</command>
    </action>
  </item>
  <item label="Reconfigure">
    <action name="Reconfigure" />
  </item>
  <separator />
  <item label="Exit">
    <action name="Exit" />
  </item>
</menu>

</openbox_menu>

OBDONE

# workaround to start nm-applet automatically
#cp /etc/xdg/autostart/nm-applet.desktop /usr/share/autostart/

# disable screensaver locking
gconftool-2 --direct --config-source=xml:readwrite:/etc/gconf/gconf.xml.defaults -s -t bool /apps/gnome-screensaver/lock_enabled false >/dev/null
# set up timed auto-login for after 30 seconds
cat >> /etc/gdm/custom.conf << FOE
[daemon]
TimedLoginEnable=true
TimedLogin=liveuser
TimedLoginDelay=30
FOE
#last thing to do
chown -R liveuser:liveuser /home/liveuser
restorecon -R /home/liveuser
EOF

%end

