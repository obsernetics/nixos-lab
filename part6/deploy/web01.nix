{ config, pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";

  networking.hostName = "web01";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  services.openssh.enable = true;
  users.users.nixos = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEpWoinUZRLki5Dybg4OIGINPNBJ4wWlvzxIUY+v5x14 airgap-lab"
    ];
  };
  security.sudo.wheelNeedsPassword = false;

  services.nginx = {
    enable = true;
    virtualHosts."web01" = {
      default = true;
      locations."/".root = pkgs.writeTextDir "index.html" ''
        <h1>web01 deployed remotely by NixOS</h1>
      '';
    };
  };
  networking.firewall.allowedTCPPorts = [ 80 ];

  system.stateVersion = "25.05";
}
