# Filename:
#   fedora-livecd-security-xfce.ks
# Description:
#   A fully functional live OS based on Fedora for use in security auditing, 
#   forensics research, and penetration testing.
# Maintainers:
#   Christoph Wickert <cwickert [AT] fedoraproject <dot> org>
#   Joerg Simon <jsimon [AT] fedoraproject <dot> org>
#   Fabian Affolter <fab [AT] fedoraproject <dot> org>
# Acknowledgements:
#   Fedora LiveCD Xfce Spin team - some work here was inherited, many thanks!
#   Fedora LXDE Spin - Copied over stuff to make LXDE Default
#   Luke Macken, Adam Miller for the original OpenBox Security ks and all
#   the Security Applications! 
#   Hiemanshu Sharma <hiemanshu [AT] fedoraproject <dot> org>

%include fedora-live-base.ks
%include fedora-live-minimization.ks

%packages
@xfce-desktop
@xfce-apps
#@xfce-extra-plugins
#@xfce-media
#@xfce-office
#@firefox

# Security tools (not ready at the moment)
#@security-lab

# save some space
-autofs
-acpid
-gimp-help
-desktop-backgrounds-basic
-realmd                     # only seems to be used in GNOME
-PackageKit*                # we switched to yumex, so we don't need this
-aspell-*                   # dictionaries are big
#-man-pages-*

# drop some system-config things
-system-config-boot
-system-config-lvm
-system-config-network
-system-config-rootpassword
#-system-config-services
-policycoreutils-gui

# Security tools (to use as long the comps group is not ready.
# python security-lab-maintenance.py -d
security-menus
xprobe2
dsniff
wireshark-gnome
john
ophcrack
medusa
chkrootkit
aide
pads
rkhunter
labrea
nebula
splint
pscan
flawfinder
rats
aircrack-ng
airsnort
kismet
weplab
wavemon
hping3
ncrack
nmap
nmap-frontend
p0f
sing
scapy
socat
tcpdump
unicornscan
nbtscan
tcpxtract
firewalk
hunt
dnsenum
iftop
scamper
argus
ettercap
ettercap-gtk
packETH
iptraf-ng
etherape
lynis
netsniff-ng
tcpjunk
ssldump
yersinia
openvas-client
ddrescue
gparted
testdisk
foremost
sectool-gui
unhide
examiner
srm
nwipe
firstaidkit-gui
nc6
nc
mc
screen
macchanger
ngrep
ntfs-3g
ntfsprogs
xmount
dc3dd
afftools
pcapdiff
net-snmp
openvas-scanner
hexedit
scanmem
sleuthkit
irssi
powertop
mutt
nano
vim-enhanced
wget
yum-utils
sipsak
sipp
firstaidkit-plugin-all
halberd
httping
nikto
ratproxy
lbd
skipfish
sqlninja

%end

%post
# xfce configuration

# create /etc/sysconfig/desktop (needed for installation)

cat > /etc/sysconfig/desktop <<EOF
PREFERRED=/usr/bin/startxfce4
DISPLAYMANAGER=/usr/sbin/lightdm
EOF

cat >> /etc/rc.d/init.d/livesys << EOF

mkdir -p /home/liveuser/.config/xfce4

cat > /home/liveuser/.config/xfce4/helpers.rc << FOE
MailReader=sylpheed-claws
FileManager=Thunar
FOE

# disable screensaver locking (#674410)
cat >> /home/liveuser/.xscreensaver << FOE
mode:           off
lock:           False
dpmsEnabled:    False
FOE

# deactivate xfconf-migration (#683161)
rm -f /etc/xdg/autostart/xfconf-migration-4.6.desktop || :

# deactivate xfce4-panel first-run dialog (#693569)
mkdir -p /home/liveuser/.config/xfce4/xfconf/xfce-perchannel-xml
cp /etc/xdg/xfce4/panel/default.xml /home/liveuser/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml

# set up lightdm autologin
sed -i 's/^#autologin-user=/autologin-user=liveuser/' /etc/lightdm/lightdm.conf 
sed -i 's/^#autologin-user-timeout=0/autologin-user-timeout=30/' /etc/lightdm/lightdm.conf
sed -i 's/^#show-language-selector=false/show-language-selector=true/' /etc/lightdm/lightdm-gtk-greeter.conf

# Show harddisk install on the desktop
sed -i -e 's/NoDisplay=true/NoDisplay=false/' /usr/share/applications/liveinst.desktop
mkdir /home/liveuser/Desktop
cp /usr/share/applications/liveinst.desktop /home/liveuser/Desktop

# this goes at the end after all other changes. 
chown -R liveuser:liveuser /home/liveuser
restorecon -R /home/liveuser

EOF

%end
