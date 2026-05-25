F_install rust

# Karabiner-Elements is required on macOS as the virtual HID driver backend.
# After install, open Karabiner-Elements and complete these manual steps:
#   1. System Settings > Privacy & Security > Input Monitoring — grant access to karabiner_grabber and karabiner_observer
#   2. System Settings > Privacy & Security > Accessibility — grant access to Karabiner-Elements
#   3. Allow the Karabiner-DriverKit-VirtualHIDDevice system extension when prompted
# Once done, Karabiner-Elements must be QUIT so kanata can claim the virtual device.
F_install karabiner

# Quit Karabiner-Elements so kanata can take exclusive control of the virtual HID device.
osascript -e 'quit app "Karabiner-Elements"' 2>/dev/null || true
