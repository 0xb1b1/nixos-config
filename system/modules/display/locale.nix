{
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";

  # Configure keymap in X11.
  services.xserver = {
  layout = "us,ru";
  xkbOptions = "grp:alt_space_toggle,compose:ralt";
  };
}
