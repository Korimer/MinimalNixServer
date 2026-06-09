{
  users.groups.Administrator = {};
  users.users.Administrator = {
    description = "Service Admin";
    createHome = false;
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };
  services.openssh.extraConfig = ''
    Match User Administrator
      PasswordAuthentication yes
      KbdInteractiveAuthentication yes
  '';
}
