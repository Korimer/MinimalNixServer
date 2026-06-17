{
  users.groups.asya = {};
  users.users.asya = {
    description = "Service Admin";
    createHome = false;
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };
  services.openssh.extraConfig = ''
    Match User asya
      PasswordAuthentication yes
      KbdInteractiveAuthentication yes
  '';
}
