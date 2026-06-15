# Please read the comments!
{ config, pkgs, lib, ... }:
{
  # Boot
  boot.loader.grub.enable = false;
  boot.loader.raspberryPi.enable = true;
  boot.loader.raspberryPi.version = 3;
  boot.loader.raspberryPi.uboot.enable = true;

  # Kernel configuration
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = ["cma=32M"];

  # Enable additional firmware (such as Wi-Fi drivers).
  hardware.enableRedistributableFirmware = true;

  # Filesystems
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/44444444-4444-4444-8888-888888888888";
      fsType = "ext4";
    };
  };
  swapDevices = [ { device = "/swapfile"; size = 1024; } ];

  # Networking (see official manual or `/config/sd-image.nix` in this repo for other options)
  networking.hostName = "vorkuta"; # unleash your creativity!

  # Packages
  environment.systemPackages = with pkgs; [
    # customize as needed!
    vim git htop
  ];

  # Miscellaneous
  time.timeZone = "America/Denver"; # you probably want to change this -- otherwise, ciao!
  services.openssh.enable = true;

  # WARNING: if you remove this, then you need to assign a password to your user, otherwise
  # `sudo` won't work. You can do that either by using `passwd` after the first rebuild or
  # by setting an hashed password in the `users.users.yourName` block as `initialHashedPassword`.
  security.sudo.wheelNeedsPassword = false;

  # Nix
  nix.gc.automatic = true;
  nix.gc.options = "--delete-older-than 30d";
  boot.cleanTmpDir = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "26.05";
}
