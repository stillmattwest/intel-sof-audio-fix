Name:           intel-sof-audio-fix
Version:        1.0.0
Release:        1%{?dist}
Summary:        Fix audio on Intel Broadwell/Haswell laptops using SOF
License:        Public Domain
URL:            https://github.com/stillmattwest/intel-sof-audio-fix
BuildArch:      noarch
Requires:       dracut

%description
Forces the Sound Open Firmware (SOF) driver for Intel Broadwell (INT3438)
and Haswell (INT33C8) audio DSPs, replacing the legacy catpt driver.

Affected laptops include the HP Spectre x360 (2015), and other Broadwell
and Haswell era laptops with I2C-connected audio codecs (RT286, RT5640,
RT5650, RT5677).

This package installs a modprobe.d configuration that:
  - Sets snd_intel_dspcfg.dsp_driver=3 to select the SOF driver
  - Blacklists the legacy snd_soc_catpt driver

Safe to install on any system. Has no effect on hardware without
Broadwell/Haswell audio DSPs.

%install
mkdir -p %{buildroot}/etc/modprobe.d
cp %{_sourcedir}/intel-broadwell-sof-audio.conf %{buildroot}/etc/modprobe.d/

%files
%config(noreplace) /etc/modprobe.d/intel-broadwell-sof-audio.conf

%post
if command -v dracut > /dev/null 2>&1; then
    dracut --force 2>/dev/null || true
fi

%postun
if command -v dracut > /dev/null 2>&1; then
    dracut --force 2>/dev/null || true
fi
