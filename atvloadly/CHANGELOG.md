# Changelog

All notable changes to this Home Assistant add-on are documented here.

## 0.1.2 - 2026-11-02

### Changed
- Promoted the Home Assistant add-on build based on upstream atvloadly `v0.8.2` to stable.
- Kept the Home Assistant wrapper, private D-Bus, Avahi discovery configuration, host networking, and persistent `/data` volume.
- Published the stable add-on image with its versioned tag and the `latest` tag.

### Validation
- Verified on Home Assistant OS; the add-on starts and operates correctly with upstream atvloadly `v0.8.2`.

## 0.1.1 - 2026-10-30

### Added
- Added the official atvloadly icon to the Home Assistant add-on page.

### Changed
- Reduced Avahi log verbosity by running it without debug mode.
- Configured Avahi to keep automatic interface discovery and service browsing while disabling publication of the add-on's own mDNS records.
- Kept IPv4 and IPv6 enabled; no network interface name is hard-coded.

### Notes
- The bundled upstream atvloadly application remains at version `v0.7.4`. This release updates the Home Assistant add-on wrapper, not the upstream application.
