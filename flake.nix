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
          value = import "${./modules}/${trimmed}.nix";
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

    nixosConfigurations.aarm64-linux.default = nixpkgs.lib.nixosSystem {
      modules = [ self.nixosModules.complete ];
    };

    packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;

    packages.x86_64-linux.default = self.packages.x86_64-linux.hello;

  };
}
