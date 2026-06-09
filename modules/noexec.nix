# Make /nix/store/ the only thing thats actually executable
{
  fileSystems = builtins.listToAttrs (map
    (path: {
      name = path;
      value = {options = [ "noexec" ];};
    })
    [ "/" "/etc/nixos" "/srv" "/var/log" ]
  );
}
