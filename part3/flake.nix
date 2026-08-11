{
  description = "Obsernetics reproducible dev shell";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        packages = [ pkgs.jq pkgs.ripgrep pkgs.python3 ];
      };

      packages.${system}.greet = pkgs.writeShellApplication {
        name = "greet";
        runtimeInputs = [ pkgs.hello ];
        text = ''hello -g "Hello from a flake"'';
      };
    };
}
