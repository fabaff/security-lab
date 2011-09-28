# Filename:
#   fedora-livecd-security.ks
# Description:
#   A fully functional live OS based on Fedora for use in security auditing, forensics research, and penetration testing.
# Maintainers:
#  Christoph Wickert <cwickert [AT] fedoraproject <dot> org>
#  Joerg Simon  <jsimon [AT] fedoraproject <dot> org>
# Acknowledgements:
#   Fedora LiveCD Xfce Spin team - some work here was inherited, many thanks!
#   Fedora LXDE Spin - Copied over stuff to make LXDE Default
#   Luke Macken, Adam Miller for the original OpenBox Security ks and all the Security Applications! 
#   Hiemanshu Sharma <hiemanshu [AT] fedoraproject <dot> org>
# Important!!!!
#   Beginning with Security Stuff - we use pattern to parse the kickstart-file for building the security menu - please use 
#   # Category: Categoryname <- for new Categories
#   # Command: Commandname <- for the given Command
#   # rCommand: Commandname <- for a command as root
#   # Entry: Menu-Entry <- for the MenuEntry Name (optional)


%include fedora-live-base.ks
%include fedora-live-minimization.ks

%packages
### LXDE desktop
@lxde-desktop
lxlauncher
obconf
lxdm

### internet
firefox
icedtea-web
midori
claws-mail

### audio & video
alsa-plugins-pulseaudio
asunder
lxmusic
pavucontrol

### system
gigolo

### more desktop stuff
fedora-icon-theme
adwaita-cursor-theme
adwaita-gtk2-theme
adwaita-gtk3-theme

# pam-fprint causes a segfault in LXDM when enabled
-fprintd-pam

# needed for automatic unlocking of keyring (#643435)
gnome-keyring-pam

gnome-bluetooth

# needed for xdg-open to support LXDE
perl-File-MimeInfo

xdg-user-dirs-gtk

gnome-packagekit*
-kpackagekit

# LXDE has lxpolkit. Make sure no other authentication agents end up in the spin.
-polkit-gnome
-polkit-kde

# make sure xfce4-notifyd is not pulled in
notification-daemon
-xfce4-notifyd

# make sure xfwm4 is not pulled in for firstboot
# https://bugzilla.redhat.com/show_bug.cgi?id=643416
metacity

# Command line
irssi
powertop
wget
yum-utils
yum-presto

# dictionaries are big
-aspell-*
-hunspell-*
-man-pages-*
-words

# more fun with space saving
-gimp-help


# pam-fprint causes a segfault in LXDM when enabled
-fprintd-pam

# save some space
-autofs
-sendmail
ssmtp
-acpid

# drop some system-config things
-system-config-boot
#-system-config-language
-system-config-lvm
-system-config-network
-system-config-rootpassword
#-system-config-services
-policycoreutils-gui

# Useful tools
lsof
scrot
epdfview
vlock

# Other necessary components
screen
#desktop-backgrounds-basic
feh
vim-enhanced
gnome-menus
gnome-terminal

# make sure debuginfo doesn't end up on the live image
-*debug


###################### Security Stuffs ############################
security-menus
##################################################################
# Category: Reconnaissance
# rCommand: dsniff -h
dsniff
# rCommand: hping -h
hping3
nc6
nc
# Command: ncrack -h
ncrack
ngrep
# rCommand: nmap -h
nmap
# Command: zenmap-root
nmap-frontend
# Command: p0f -h
p0f
# rCommand: sing -h
sing
# Command: scanssh -h
#temp takout scanssh
# rCommand: scapy -h
scapy
# Command: socat
# Entry: Socket cat
socat
# rCommand: tcpdump -h
tcpdump
# rCommand: unicornscan -h
unicornscan
# rCommand: wireshark
# Entry: Wireshark
wireshark-gnome
# Command: xprobe2
xprobe2
# Command: nbtscan
nbtscan
# Command: tcpxtract
tcpxtract
# Command: firewalk
# Entry: Firewalk
firewalk
# Command: hunt
# Entry: Hunt
hunt
# Command: dnsenum -h
# Entry: DNS Enumeration
dnsenum
# rCommand: iftop
iftop
# Command: argus -h
argus
# rCommand: ettercap -C
# Entry: Ettercap
ettercap
ettercap-gtk
# rCommand: packETH
packETH
# rCommand: iptraf
iptraf
pcapdiff
# rCommand: etherape
etherape
# Command: lynis
lynis
# rCommand: netsniff-ng
netsniff-ng
# Command: tcpjunk -x
tcpjunk
# rCommand: ssldump -h
ssldump
# rCommand: yersinia -G
# Entry: Yersinia
yersinia
net-snmp
# Command: openvas-client
# Entry: OpenVAS Client
openvas-client
openvas-scanner

#################################################################
# Category: Forensics
# Command: ddrescue -h
ddrescue
# Command: gparted
gparted
hexedit
# rCommand: testdisk -h
testdisk
# Command: foremost -h
# Entry: Foremost Filecarver
foremost
# Command: sectool-gui
# Entry: sectool
sectool-gui
scanmem
sleuthkit
# Command: unhide
unhide
# Command: examiner
# Entry: ELF Examiner
examiner
dc3dd
afftools
# Command: srm -h
# Entry: Securely Remove Files
srm
# Command: firstaidkit -g gtk
# Entry: First Aid Kit
firstaidkit-plugin-all
ntfs-3g
ntfsprogs

#####################################################################
# Category: WebApplicationTesting
# Command: httping -h
httping
# Command: nikto -help
# Entry: Nikto Websecurity Scanner
nikto
# Command: ratproxy -h
ratproxy
# Command: lbd
# Entry: Load Balancing Detector
lbd
# Command: skipfish
skipfish

#######################################################################
# Category: Wireless
# Command: aircrack-ng
aircrack-ng
# Command: airsnort
airsnort
# rCommand: kismet
kismet
# Command: weplab
# Entry: weplab - Wep Key Cracker
weplab
# Command: wavemon
wavemon

#######################################################################
# Category: CodeAnalysis
# Command: splint
splint
# Command: pscan
pscan
# Command: flawfinder
# Entry: Flawfinder
flawfinder
# Command: rats
# Entry: Rough Auditing Tool for Security
rats

######################################################################
# Category: IntrusionDetection
# rCommand: chkrootkit
chkrootkit
# Command: aide -h
aide
labrea
# Command: honeyd -h
# Entry: Honeypot Daemon
# temp removal
#honeyd
# Command: pads -h
# Entry: Passive Asset Detection System
pads
nebula
# Command: rkhunter
# Entry: RootKitHunter
rkhunter

########################################################################
# Category: PasswordTools
# Command: john 
john
# Command: ophcrack 
# Entry: Objectif Securite ophcrack
ophcrack
# Command: medusa -d
# Entry: Medusa Brute Force
medusa


%end

%post
# LXDE and LXDM configuration

# create /etc/sysconfig/desktop (needed for installation)
cat > /etc/sysconfig/desktop <<EOF
PREFERRED=/usr/bin/startlxde
DISPLAYMANAGER=/usr/sbin/lxdm
EOF

cat >> /etc/rc.d/init.d/livesys << EOF
# disable screensaver locking and make sure gamin gets started
cat > /etc/xdg/lxsession/LXDE/autostart << FOE
/usr/libexec/gam_server
@lxpanel --profile LXDE
@pcmanfm --desktop --profile LXDE
@pulseaudio -D
FOE

# set up preferred apps 
cat > /etc/xdg/libfm/pref-apps.conf << FOE 
[Preferred Applications]
WebBrowser=mozilla-firefox.desktop
MailClient=fedora-claws-mail.desktop
FOE

# set up auto-login for liveuser
sed -i 's|# autologin=dgod|autologin=liveuser|g' /etc/lxdm/lxdm.conf

# Show harddisk install on the desktop
sed -i -e 's/NoDisplay=true/NoDisplay=false/' /usr/share/applications/liveinst.desktop
mkdir /home/liveuser/Desktop
cp /usr/share/applications/liveinst.desktop /home/liveuser/Desktop

# Add autostart for parcellite
cp /usr/share/applications/fedora-parcellite.desktop /etc/xdg/autostart

# this goes at the end after all other changes.
chown -R liveuser:liveuser /home/liveuser
restorecon -R /home/liveuser

EOF

%end

