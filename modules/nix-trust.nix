{
  nix.allowedUsers = [ "@wheel" ];
  nix.settings.trustedUsers = [ "root" "@wheel" ];
  networking.wireless.enable = false;
}
