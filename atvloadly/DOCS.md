# atvloadly for Home Assistant OS

This add-on packages the upstream `ghcr.io/bitxeno/atvloadly:v0.8.2` image for Home Assistant OS (amd64), adds Avahi and D-Bus inside the container, and runs the original atvloadly entrypoint.

## Test build

This branch is a prerelease for validating upstream atvloadly v0.8.2. It is intentionally versioned separately from the stable add-on release. Do not merge it into the stable branch until authentication, discovery, installation, and persistent-state tests have passed.

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

The test build pins upstream atvloadly to `v0.8.2`. The stable branch remains on its existing upstream version until this prerelease has been tested and intentionally promoted.
