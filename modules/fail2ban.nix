{
  services.fail2ban = {
    enable = true;

    maxretry = 5;
    bantime = "5m";
    bantime-increment = {
      enable = true;
      formula = "ban.Time * math.exp(float(ban.Count+1)*banFactor)/math.exp(1*banFactor)";
      multipliers = "1 6 288 999999999999999"; # 5m; 30m; 1d; eternity
      maxtime = "876000h"; # you can wait 100 years. its alright
        overalljails = true;
    };
  };

}
