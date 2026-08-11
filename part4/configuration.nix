{ config, pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  # BIOS GRUB on the virtio disk.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";

  networking.hostName = "lab";
  time.timeZone = "UTC";

  # Enable the new nix command and flakes.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
  };

  users.users.nixos = {
    isNormalUser = true;
    description = "Obsernetics lab user";
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEpWoinUZRLki5Dybg4OIGINPNBJ4wWlvzxIUY+v5x14 airgap-lab"
    ];
    initialPassword = "nixos";
  };
  security.sudo.wheelNeedsPassword = false;

  environment.systemPackages = with pkgs; [ git vim ];

  system.stateVersion = "25.05";
}
