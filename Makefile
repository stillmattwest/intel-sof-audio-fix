PACKAGE := intel-sof-audio-fix
VERSION := $(shell grep '^Version:' DEBIAN/control | awk '{print $$2}')
DEB     := $(PACKAGE)_$(VERSION)_all.deb
BUILDDIR := build

.PHONY: all clean

all: $(DEB)

$(DEB):
	mkdir -p $(BUILDDIR)/DEBIAN
	mkdir -p $(BUILDDIR)/etc/modprobe.d
	cp DEBIAN/control $(BUILDDIR)/DEBIAN/
	cp DEBIAN/postinst $(BUILDDIR)/DEBIAN/
	cp DEBIAN/postrm $(BUILDDIR)/DEBIAN/
	chmod 0755 $(BUILDDIR)/DEBIAN/postinst $(BUILDDIR)/DEBIAN/postrm
	cp etc/modprobe.d/intel-broadwell-sof-audio.conf $(BUILDDIR)/etc/modprobe.d/
	dpkg-deb --build $(BUILDDIR) $(DEB)

clean:
	rm -rf $(BUILDDIR) $(PACKAGE)_*_all.deb
