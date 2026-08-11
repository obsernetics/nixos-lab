# Part 4 - Installing and configuring NixOS declaratively

The whole machine is described in `configuration.nix` (plus a generated
`hardware-configuration.nix`).

```sh
sudo nixos-generate-config          # writes hardware-configuration.nix for this machine
sudo $EDITOR /etc/nixos/configuration.nix
sudo nixos-rebuild switch           # build + activate, registers a new generation
nixos-rebuild list-generations
```

## Change and roll back

Add a package (e.g. `htop`) to `environment.systemPackages`, then:

```sh
sudo nixos-rebuild switch           # new generation, htop available
sudo nixos-rebuild switch --rollback  # back to the previous generation, one command
```

Old generations also stay in the boot menu, so a broken change never locks you out.
