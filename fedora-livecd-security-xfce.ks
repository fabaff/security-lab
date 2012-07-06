# Filename:
#   fedora-livecd-security.ks
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
#   Luke Macken, Adam Miller for the original OpenBox Security ks and al
#   the Security Applications! 
#   Hiemanshu Sharma <hiemanshu [AT] fedoraproject <dot> org>
# Important!!!!
#   Beginning with Security Stuff - we use pattern to parse the kickstart 
#   file for building the security menu - please use 
#   # Category: Categoryname <- for new Categories
#   # Command: Commandname <- for the given Command
#   # rCommand: Commandname <- for a command as root
#   # Entry: Menu-Entry <- for the MenuEntry Name (optional)

%include fedora-live-base.ks
%include fedora-live-minimization.ks

%packages
# Office
#abiword
#gnumeric

# Graphics
epdfview

# Development
#geany

# Internet
#firefox
# Add the midori browser as a lighter alternative
midori
claws-mail
#claws-mail-plugins-archive
#claws-mail-plugins-att-remover
#claws-mail-plugins-attachwarner
#claws-mail-plugins-bogofilter
#claws-mail-plugins-fetchinfo
#claws-mail-plugins-mailmbox
#claws-mail-plugins-newmail
#claws-mail-plugins-notification
#claws-mail-plugins-pgp
#claws-mail-plugins-rssyl
#claws-mail-plugins-smime
#claws-mail-plugins-spam-report
#claws-mail-plugins-tnef
#claws-mail-plugins-vcalendar
#liferea
#pidgin
remmina
remmina-plugins-rdp
remmina-plugins-vnc
#transmission

# Sound & Video
alsa-plugins-pulseaudio
#asunder
#cheese
pavucontrol
#parole
#pragha
xfburn

# System
#gparted
-gnome-disk-utility
gigolo
setroubleshoot

# Accessories
catfish
galculator
seahorse
ConsoleKit-x11

# More Desktop stuff
# java plugin
icedtea-web
NetworkManager-vpnc
NetworkManager-openvpn
NetworkManager-pptp
gnome-bluetooth
xscreensaver
xdg-user-dirs-gtk

# FIXME: work around #746693
metacity

# default artwork
fedora-icon-theme
adwaita-cursor-theme
adwaita-gtk2-theme
adwaita-gtk3-theme

# command line
irssi
mutt
ntfs-3g
powertop
#rtorrent
vim-enhanced
wget
yum-utils

# Xfce packages
@xfce-desktop
ristretto
thunar-media-tags-plugin
xfce4-battery-plugin
xfce4-cellmodem-plugin
xfce4-clipman-plugin
xfce4-cpugraph-plugin
xfce4-datetime-plugin
xfce4-dict-plugin
xfce4-diskperf-plugin
xfce4-eyes-plugin
xfce4-fsguard-plugin
xfce4-genmon-plugin
xfce4-mailwatch-plugin
xfce4-mount-plugin
xfce4-netload-plugin
xfce4-notes-plugin
xfce4-places-plugin
xfce4-quicklauncher-plugin
xfce4-screenshooter-plugin
xfce4-sensors-plugin
xfce4-smartbookmark-plugin
xfce4-systemload-plugin
xfce4-taskmanager
xfce4-time-out-plugin
xfce4-timer-plugin
xfce4-verve-plugin
# we already have nm-applet
#xfce4-wavelan-plugin
xfce4-weather-plugin
xfce4-websearch-plugin
xfce4-xfswitch-plugin
xfce4-xkb-plugin
# system-config-printer does printer management better
#xfprint
xfwm4-themes

# dictionaries are big
-aspell-*
-man-pages-*

# more fun with space saving
-gimp-help
# not needed, but as long as there is space left, we leave this in
#-desktop-backgrounds-basic

# save some space
-autofs
-acpid

# drop some system-config things
-system-config-boot
-system-config-lvm
-system-config-network
-system-config-rootpassword
#-system-config-services
-policycoreutils-gui

gnome-terminal
macchanger

# Metasploit
subversion
ruby-devel
ruby-irb
#ruby-ri
rubygems
postgresql-server
postgresql-devel

# we need UPower for suspend and hibernate
upower

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
# rCommand: iptraf-ng
iptraf-ng
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
# Command: nwipe
# Entry: Securely erase disks
nwipe
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
# Command: sqlninja
sqlninja

#######################################################################
# Category: Wireless
# Command: aircrack-ng
aircrack-ng
# Command: airsnort
airsnort
# rCommand: kismet
kismet
# Command: weplab
# Entry: Wep Key Cracker
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
# xfce configuration

# create /etc/sysconfig/desktop (needed for installation)

cat > /etc/sysconfig/desktop <<EOF
PREFERRED=/usr/bin/startxfce4
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

# set up auto-login
cat >> /etc/gdm/custom.conf << FOE
[daemon]
AutomaticLoginEnable=True
AutomaticLogin=liveuser
FOE

# Show harddisk install on the desktop
sed -i -e 's/NoDisplay=true/NoDisplay=false/' /usr/share/applications/liveinst.desktop
mkdir /home/liveuser/Desktop
cp /usr/share/applications/liveinst.desktop /home/liveuser/Desktop

# this goes at the end after all other changes. 
chown -R liveuser:liveuser /home/liveuser
restorecon -R /home/liveuser

EOF

%end
