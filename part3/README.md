# Part 3 - Flakes and reproducible dev environments

## The flake

`flake.nix` defines a pinned `nixpkgs` input and two outputs: a `devShell`
(jq, ripgrep, python3) and a `greet` package.

```sh
nix flake lock          # writes flake.lock, freezing the exact nixpkgs revision
nix develop             # enter a shell with exactly those tools, pinned
nix flake metadata      # show the locked input
nix flake show          # list outputs
nix build .#greet && ./result/bin/greet
```

## Auto-activation with direnv

```sh
echo "use flake" > .envrc
direnv allow            # needs direnv + nix-direnv
```

Now the environment loads on `cd` in and unloads on `cd` out. `flake.lock` makes
everyone (laptop, server, CI) resolve the identical inputs.
