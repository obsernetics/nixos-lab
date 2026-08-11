# Part 1 - Concepts, install, and the Nix store

## Install Nix (multi-user, flakes enabled)

```sh
curl -sSf -L https://install.determinate.systems/nix | sh -s -- install --no-confirm
nix --version
```

## Run a package without installing it

`nix run` fetches a package and its dependencies and runs it, leaving nothing
behind in your environment:

```sh
nix run nixpkgs#cowsay -- "Nix: reproducible by design"
nix shell nixpkgs#jq    # drop into a temporary shell that has jq
```

## Install into your user profile

```sh
nix profile add nixpkgs#hello
hello
nix profile list
```

## The /nix/store, closures, and rollback

Every package lives at an immutable, hash-addressed path:

```sh
readlink -f $(which hello)          # /nix/store/<hash>-hello-2.12.3/bin/hello
nix path-info -Sh nixpkgs#hello     # total closure size
nix profile history                 # every change is a generation
nix profile rollback                # go back one generation, instantly
```

Key idea: the hash is derived from every build input. Change an input, get a new
path. Two versions never clash, and "works on my machine" mostly disappears.
