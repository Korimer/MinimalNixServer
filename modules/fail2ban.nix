{
  services.fail2ban = {
    enable = true;
    maxretry = 3;
    bantime = "5m";
    bantime-increment = {
      enable = true;
      multipliers = "1 6 288 999999999999999"; # 5m; 30m; 1d; eternity
      maxtime = "876000h"; # you can wait 100 years. its alright
        overalljails = true;
    };
  };
}
