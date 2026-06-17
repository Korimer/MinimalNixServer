{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }:
  
  let
    allModules = nixpkgs.lib.pipe (builtins.readDir ./modules)
      [
        builtins.attrNames
        (map (name: builtins.replaceStrings [ ".nix" ] [ "" ] name))
        (map (trimmed: {
          name = trimmed;
          value = "${./modules}/${trimmed}.nix";
        }))
        builtins.listToAttrs
      ];
  in

  {
    extra = allModules;
    nixosModules = 
      allModules
      //
      {
        complete.imports = (map
          (module: "${./modules}/${module}")
          (builtins.attrNames allModules)
        );
    };
  };
}
