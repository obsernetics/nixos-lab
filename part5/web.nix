{ config, pkgs, ... }:
{
  # A web server, declared once. NixOS wires up the systemd unit, user and dirs.
  services.nginx = {
    enable = true;
    virtualHosts."lab" = {
      default = true;
      locations."/".root = pkgs.writeTextDir "index.html" ''
        <h1>Served by NixOS + nginx</h1>
      '';
    };
  };

  # Only what we open is reachable.
  networking.firewall.allowedTCPPorts = [ 80 ];

  # An extra, unprivileged deploy user.
  users.users.deploy = {
    isNormalUser = true;
    description = "CI / deploy user";
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEpWoinUZRLki5Dybg4OIGINPNBJ4wWlvzxIUY+v5x14 airgap-lab"
    ];
  };

  # A custom systemd service, described declaratively.
  systemd.services.obsernetics-hello = {
    description = "Obsernetics hello oneshot";
    wantedBy = [ "multi-user.target" ];
    serviceConfig.Type = "oneshot";
    script = ''
      echo "hello from a NixOS-managed service at $(date -u +%FT%TZ)" \
        > /var/log/obsernetics-hello.log
    '';
  };
}
