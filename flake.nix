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

    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      modules = [
        ./raspi-basics/base.nix
      ];
    };

    packages.x86_64-linux = {
      image = self.nixosConfigurations.default.config.system.build.image;

      image-aarch64 = (self.nixosConfigurations.default.extendModules {
        modules = [
          {
            nixpkgs.buildPlatform = "x86_64-linux";
            nixpkgs.hostPlatform = "aarch64-linux";
          }
        ];
      }).config.system.build.image;
    };
  };
}
