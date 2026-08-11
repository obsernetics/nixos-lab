{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball
    "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in
{
  imports = [ (import "${home-manager}/nixos") ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  # The nixos user's whole environment, declared.
  home-manager.users.nixos = { pkgs, ... }: {
    home.stateVersion = "25.05";
    home.packages = [ pkgs.bat pkgs.eza ];

    programs.git = {
      enable = true;
      userName = "Obsernetics Lab";
      userEmail = "lab@obsernetics.local";
    };

    programs.bash = {
      enable = true;
      shellAliases.ll = "eza -l --icons";
    };
  };
}
