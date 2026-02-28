PACKAGE := intel-sof-audio-fix
VERSION := $(shell grep '^Version:' DEBIAN/control | awk '{print $$2}')
DEB     := $(PACKAGE)_$(VERSION)_all.deb
RPM_TOPDIR := $(CURDIR)/rpmbuild
BUILDDIR := build

.PHONY: all deb rpm clean

all: deb

deb: $(DEB)

$(DEB):
	mkdir -p $(BUILDDIR)/DEBIAN
	mkdir -p $(BUILDDIR)/etc/modprobe.d
	cp DEBIAN/control $(BUILDDIR)/DEBIAN/
	cp DEBIAN/postinst $(BUILDDIR)/DEBIAN/
	cp DEBIAN/postrm $(BUILDDIR)/DEBIAN/
	chmod 0755 $(BUILDDIR)/DEBIAN/postinst $(BUILDDIR)/DEBIAN/postrm
	cp etc/modprobe.d/intel-broadwell-sof-audio.conf $(BUILDDIR)/etc/modprobe.d/
	dpkg-deb --build $(BUILDDIR) $(DEB)

rpm:
	mkdir -p $(RPM_TOPDIR)/{SOURCES,SPECS,BUILD,RPMS,SRPMS}
	cp etc/modprobe.d/intel-broadwell-sof-audio.conf $(RPM_TOPDIR)/SOURCES/
	cp $(PACKAGE).spec $(RPM_TOPDIR)/SPECS/
	rpmbuild --define "_topdir $(RPM_TOPDIR)" -bb $(RPM_TOPDIR)/SPECS/$(PACKAGE).spec
	cp $(RPM_TOPDIR)/RPMS/noarch/$(PACKAGE)-*.noarch.rpm .

clean:
	rm -rf $(BUILDDIR) $(RPM_TOPDIR) $(PACKAGE)_*_all.deb $(PACKAGE)-*.noarch.rpm
