PREFIX=/usr
DATADIR=$(PREFIX)/share
SYSCONFDIR=/etc
INSTALL=/usr/bin/install -p

all:

clean:

install:
	mkdir -p $(DESTDIR)$(SYSCONFDIR)/xdg/menus/applications-merged
	$(INSTALL) -p -m 0644 security-lab.menu $(DESTDIR)$(SYSCONFDIR)/xdg/menus/applications-merged
	mkdir -p $(DESTDIR)$(DATADIR)/desktop-directories
	mkdir -p $(DESTDIR)$(DATADIR)/applications
	$(INSTALL) -p -m 0644 -D desktop-directories/*.directory $(DESTDIR)$(DATADIR)/desktop-directories
	$(INSTALL) -p -m 0644 -D applications/*.desktop $(DESTDIR)/usr/share/applications

.PHONY: all clean $(INSTALL)
