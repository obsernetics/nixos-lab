let
  pkgs = import <nixpkgs> { };
in
pkgs.writeShellApplication {
  name = "greet";
  runtimeInputs = [ pkgs.hello ];
  text = ''
    hello -g "Hello from a reproducible Nix build"
  '';
}
