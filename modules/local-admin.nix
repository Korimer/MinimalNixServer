{
  users.groups.Administrator = {};
  users.users.Administrator = {
    description = "Service Admin";
    createHome = false;
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };
}
