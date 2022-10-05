{ # This module contains common fixes and special configurations for laptops
  services.xserver.libinput = {
    # Fix touchpads.
    enable = true;

    # Disable touchpad while typing.
    touchpad.disableWhileTyping = true;
  };
}
