{
  description = "Obsernetics NixOS fleet";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: {
    nixosConfigurations.web01 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ ./web01.nix ];
    };
  };
}
