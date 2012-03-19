NAME=security-menus
PREFIX=/usr
DATADIR=$(PREFIX)/share
SYSCONFDIR=/etc
INSTALL=/usr/bin/install -p
VERSION=1.0
RELEASE=5
TAG=$(NAME)-$(VERSION)-$(RELEASE)

all: update-po archive

tag:
	@git tag -a -f -m "Tag as $(TAG)" -f $(TAG)
	@echo "Tagged as $(TAG)"

install:
	mkdir -p $(DESTDIR)$(SYSCONFDIR)/xdg/menus/applications-merged
	$(INSTALL) -p -m 0644 security-lab.menu $(DESTDIR)$(SYSCONFDIR)/xdg/menus/applications-merged
	mkdir -p $(DESTDIR)$(DATADIR)/desktop-directories
	mkdir -p $(DESTDIR)$(DATADIR)/applications
	$(INSTALL) -p -m 0644 -D desktop-directories/*.directory $(DESTDIR)$(DATADIR)/desktop-directories
	$(INSTALL) -p -m 0644 -D applications/*.desktop $(DESTDIR)/usr/share/applications

archive: tag
	@git archive --format=tar --prefix=$(NAME)-$(VERSION).$(RELEASE)/ HEAD > $(NAME)-$(VERSION).$(RELEASE).tar
	@bzip2 -f $(NAME)-$(VERSION).$(RELEASE).tar
	@echo "$(NAME)-$(VERSION).$(RELEASE).tar.bz2 created" 
	@sha1sum $(NAME)-$(VERSION).$(RELEASE).tar.bz2 > $(NAME)-$(VERSION).$(RELEASE).sha1sum 
	@scp $(NAME)-$(VERSION).$(RELEASE).tar.bz2 $(NAME)-$(VERSION).$(RELEASE).sha1sum www.fedorahosted.org:security-spin
	@echo "Everything done, files uploaded to Fedorahosted.org" 

clean:
	rm -f *~ *bz2

.PHONY: all clean $(INSTALL)
