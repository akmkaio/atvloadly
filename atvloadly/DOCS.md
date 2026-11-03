# atvloadly for Home Assistant OS

This add-on packages the original [atvloadly project](https://github.com/bitxeno/atvloadly) for Home Assistant OS (amd64). It adds the Avahi and D-Bus services required for network discovery and runs the original atvloadly application.

## Current upstream version

This add-on currently uses upstream atvloadly `v0.8.2`. The Home Assistant add-on has its own independent version number.

## Disclaimer and transparency

This Home Assistant add-on was created with the assistance of AI tools.

Its purpose is to provide a lightweight packaging of the original upstream atvloadly project for Home Assistant OS. It does not aim to replace or independently modify the upstream application beyond the adaptations required to run it as a Home Assistant add-on.

**Please be aware of the following limitations:**

- The add-on code and configuration have not undergone an independent security audit or formal code review.
- Testing has been performed only on the maintainer's own Home Assistant OS installation and hardware.
- Compatibility and reliability have not been verified on other Home Assistant installations, hardware configurations, or network environments.
- Successful operation in the maintainer's environment does not guarantee that the add-on will work as expected in every setup.

Use it at your own discretion. Always keep backups of your Home Assistant data, especially the add-on's persistent data.

This project is community-driven and is provided as-is, without any guarantee of functionality, security, or compatibility.

## Network and access

- The add-on uses host networking to support Apple TV discovery through multicast/mDNS.
- Avahi and D-Bus run inside the add-on container to support network discovery.
- Home Assistant and the Apple TV should be on the same local network, with multicast traffic allowed.
- The web interface is available directly at `http://<HOME_ASSISTANT_IP>:5533`.
- The interface is not accessed through Home Assistant ingress.

**Security notice:** atvloadly does not provide built-in authentication. Because the add-on uses host networking, its web interface may be accessible to other devices on your local network.

Do not expose port `5533` to the public internet. Use it only on a trusted network and apply firewall restrictions where appropriate.

## Persistent data

The add-on uses Home Assistant's persistent `/data` directory to store atvloadly's database, pairing information, configuration, and deployment/signing key material.

- This data is preserved across normal add-on restarts and updates.
- Back up the add-on's data before reinstalling, migrating, or rebuilding it.
- Do not delete the add-on's data if you want to preserve your Apple TV pairing and signing identity.
- Never share backups or logs that may contain sensitive information.

## Apple Account and signing

Use a dedicated Apple Account for sideloading if possible.

Apple Account credentials, pairing information, and signing material are sensitive. Protect access to Home Assistant and keep the add-on's persistent data private.

Apple's account type and security requirements may affect authentication and app signing. Refer to the [upstream atvloadly project](https://github.com/bitxeno/atvloadly) for information about its Apple authentication and signing requirements.

## Troubleshooting

- **Apple TV not detected:** Check that Home Assistant and the Apple TV are on the same local network and that multicast/mDNS traffic is not blocked by VLANs, client isolation, or firewall rules.
- **Avahi fails to start:** Check the add-on logs for D-Bus startup errors or another service already using UDP port `5353`.
- **Apple authentication fails:** Check your Apple Account credentials and authentication settings. Authentication problems may originate from Apple's services or account security requirements rather than the Home Assistant packaging. Avoid repeated rapid login attempts.
