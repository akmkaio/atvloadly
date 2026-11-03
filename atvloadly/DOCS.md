# atvloadly for Home Assistant OS

This add-on packages the upstream `ghcr.io/bitxeno/atvloadly:v0.8.2` image for Home Assistant OS (amd64), adds Avahi and D-Bus inside the container, and runs the original atvloadly entrypoint.

## Version

The stable Home Assistant add-on release is based on upstream atvloadly `v0.8.2`. This version has been validated on Home Assistant OS.

## Disclaimer and transparency

This Home Assistant add-on was created with the assistance of AI tools.

Its purpose is to provide a lightweight packaging of the original [upstream atvloadly project](https://github.com/bitxeno/atvloadly) for Home Assistant OS. It does not aim to replace or independently modify the upstream application beyond the adaptations required to run it as a Home Assistant add-on.

**Please be aware of the following limitations:**

- The add-on code and configuration have not undergone an independent security audit or formal code review.
- Testing has been performed only on the maintainer's own Home Assistant OS installation and hardware.
- Compatibility and reliability have not been verified on other Home Assistant installations, hardware configurations, or network environments.
- Although the add-on has been tested and is working in the maintainer's environment, this does not guarantee that it will work as expected in every setup.

Use it at your own discretion. Always keep backups of your Home Assistant data, especially the add-on's persistent `/data` directory.

This project is community-driven and is provided as-is, without any guarantee of functionality, security, or compatibility.

## Networking and discovery

- The add-on uses the host network so Apple TV multicast/mDNS discovery can work.
- It runs a private D-Bus and Avahi daemon inside the container; it does not mount undocumented HAOS host sockets.
- Avahi discovers available network interfaces automatically. Its configuration disables publishing the add-on's own mDNS records while keeping service browsing enabled; no interface name is hard-coded.
- The web UI is exposed directly on the Home Assistant host at port 5533 (not through Home Assistant ingress).
- Because host networking is used and atvloadly has no built-in authentication, the service's port may also be reachable directly on the LAN. Do not forward port 5533 to the public internet. Use a trusted LAN/VLAN and firewall rules as appropriate.

## Persistent state

Home Assistant maps `/data` persistently. This is where atvloadly keeps its database, pairing information, configuration, and deployment/signing key material. Back up this directory before moving or rebuilding the add-on. Do not delete the add-on's data volume if you want to preserve the pairing and signing identity.

## Apple ID and certificates

Use a dedicated Apple Account for sideloading if possible. Protect access to the Home Assistant UI and never publish `/data` backups or logs containing sensitive information. The upstream project documents Apple's free-account signing limits and the need to keep the pairing/signing data persistent.

## Troubleshooting

- If the Apple TV is not detected, check that HAOS and the Apple TV are on the same LAN and that multicast is not blocked by VLAN/client-isolation settings.
- If Avahi cannot start, inspect the logs for an existing service already bound to UDP 5353 or for a D-Bus startup failure.
- If login fails with an Apple authentication error, do not retry rapidly; this may be unrelated to the Home Assistant packaging.

## Upstream version

The add-on Dockerfile pins upstream atvloadly to `v0.8.2`. To update the upstream application, change the `FROM` line in `Dockerfile`, increment the add-on's `version` in `config.yaml`, and add the corresponding release notes to `CHANGELOG.md`. The GitHub Actions workflow builds and publishes the versioned image and updates the `latest` tag when changes are pushed to `master` or `main`.
