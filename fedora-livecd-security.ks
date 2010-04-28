# Filename:
#   fedora-livecd-security.ks
# Description:
#   A fully functional live OS based on Fedora for use in security auditing, forensics research, and penetration testing.
# Maintainers:
#  Hiemanshu Sharma <hiemanshu [AT] fedoraproject <dot> org>
#  Christoph Wickert <cwickert [AT] fedoraproject <dot> org>
#  Joerg Simon  <jsimon [AT] fedoraproject <dot> org>
# Acknowledgements:
#   Fedora LiveCD Xfce Spin team - some work here was inherited, many thanks!
#   Fedora LXDE Spin - Copied over stuff to make LXDE Default
#   Luke Macken, Adam Miller for the original OpenBox Security ks and all the Security Applications! 


%include fedora-live-base.ks
%include fedora-live-minimization.ks

%packages

# internet
firefox
claws-mail


# Command line
cnetworkmanager
irssi
mutt
ntfs-3g
powertop
wget
yum-utils
yum-presto

# dictionaries are big
#-aspell-*
#-hunspell-*
#-man-pages-*
#-words

# more fun with space saving
-gimp-help

#GUI Stuff
@lxde
Thunar 
thunar-volman
xarchiver
gnome-bluetooth
alsa-plugins-pulseaudio
pavucontrol
system-config-printer

# save some space
-autofs
-nss_db
-sendmail
ssmtp
-acpid

###################### Security Stuffs ############################
security-menus

# Reconnaissance
dsniff
hping3
nc6
nc
ncrack
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

## Apparently missing from the repositories and fails the build
#halberd

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
epdfview

# Other necessary components
screen
desktop-backgrounds-basic
feh
vim-enhanced
gnome-menus
gnome-terminal
PolicyKit-gnome

# make sure debuginfo doesn't end up on the live image
-\*debug
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
@pcmanfm2 --desktop --profile lxde
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

