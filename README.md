# intel-sof-audio-fix

Fixes audio on Intel Broadwell and Haswell laptops by forcing the SOF (Sound Open Firmware) driver instead of the legacy `catpt` driver, which fails on many systems.

## Affected hardware

- HP Spectre x360 (2015) and other Broadwell-era laptops
- Haswell-era laptops with I2C-connected audio codecs (RT286, RT5640, RT5650, RT5677)
- ACPI device IDs: `INT3438` (Broadwell), `INT33C8` (Haswell)

**Safe to install on any system** — has no effect on hardware without these audio DSPs.

## What it does

- Sets `snd_intel_dspcfg.dsp_driver=3` to select the SOF driver
- Blacklists the legacy `snd_soc_catpt` driver
- Rebuilds initramfs on install/remove

## Install

Download the `.deb` from the [latest release](../../releases/latest), then:

```bash
sudo dpkg -i intel-sof-audio-fix_1.0.0_all.deb
sudo reboot
```

## Uninstall

```bash
sudo dpkg -r intel-sof-audio-fix
sudo reboot
```

## Verify

After rebooting, check that your sound card is detected:

```bash
aplay -l
```

You should see a `bdw-rt286` or similar Broadwell/Haswell audio device.

## Build from source

```bash
make
```

Produces `intel-sof-audio-fix_1.0.0_all.deb` in the project root.

## License

Public domain. Use however you like.
