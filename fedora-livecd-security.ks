# Filename:
#   fedora-livecd-security.ks
# Description:
#   A fully functional live OS based on Fedora for use in security auditing, 
#   forensics research, and penetration testing.
# Maintainers:
#   Fabian Affolter <fab [AT] fedoraproject <dot> org>
#   Joerg Simon <jsimon [AT] fedoraproject <dot> org>
#   JT Pennington <jt [AT] fedoraproject <dor> org>
# Acknowledgements:
#   Fedora LiveCD Xfce Spin team - some work here was and will be inherited,
#   many thanks, especially to Christoph Wickert!
#   Fedora LXDE Spin - Copied over stuff to make LXDE Default
#   Luke Macken and Adam Miller for the original OpenBox Security ks and all
#   the Security Applications! 
#   Hiemanshu Sharma <hiemanshu [AT] fedoraproject <dot> org>

%include fedora-live-base.ks
%include fedora-live-minimization.ks

# spin was failing to compose due to lack of space, so bumping the size.
part / --size 10240

%packages
# install env-group to resolve RhBug:1891500
@^xfce-desktop-environment

@xfce-apps

# Security tools
@security-lab
security-menus

# unlock default keyring. FIXME: Should probably be done in comps
gnome-keyring-pam

# save some space
-autofs
-acpid
-gimp-help
-desktop-backgrounds-basic
-PackageKit*                # we switched to dnfdragora, so we don't need this
-aspell-*                   # dictionaries are big
-gnumeric
-foomatic-db-ppds
-foomatic
-stix-fonts
-ibus-typing-booster
-xfce4-sensors-plugin
-man-pages-*

# drop some system-config things
-system-config-rootpassword
-policycoreutils-gui

# exclude some packages to save some space
# use './fsl-maintenance.py -l' in your security spin git folder to build
-ArpON
-aide
-binwalk
-bkhive
-bonesi
-bro
-cmospwd
-dnstop
-etherape
-hfsutils
-httpie
-httrack
-hydra
-kismon
-labrea
-nebula
-netsed
-onesixtyone
-packETH
-pads
-pdfcrack
-proxychains
-pyrit
-raddump
-rkhunter
-safecopy
-samdump2
-scalpel
-sslstrip
-tcpreen
-tcpreplay
-tripwire
-wipe
-zmap

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
WebBrowser=midori
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
sed -i 's/^#autologin-user=.*/autologin-user=liveuser/' /etc/lightdm/lightdm.conf
sed -i 's/^#autologin-user-timeout=.*/autologin-user-timeout=0/' /etc/lightdm/lightdm.conf
#sed -i 's/^#show-language-selector=.*/show-language-selector=true/' /etc/lightdm/lightdm-gtk-greeter.conf

# set Xfce as default session, otherwise login will fail
sed -i 's/^#user-session=.*/user-session=xfce/' /etc/lightdm/lightdm.conf

# Show harddisk install on the desktop
sed -i -e 's/NoDisplay=true/NoDisplay=false/' /usr/share/applications/liveinst.desktop
mkdir /home/liveuser/Desktop
cp /usr/share/applications/liveinst.desktop /home/liveuser/Desktop

# and mark it as executable (new Xfce security feature)
chmod +x /home/liveuser/Desktop/liveinst.desktop

# this goes at the end after all other changes. 
chown -R liveuser:liveuser /home/liveuser
restorecon -R /home/liveuser

EOF

%end
