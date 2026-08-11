# Part 2 - The Nix language and Nixpkgs

## The language in a nutshell (`nix repl`)

```nix
1 + 2                                      # => 3
let greeting = "Nix"; in "Hello, ${greeting}"   # => "Hello, Nix"
let add = a: b: a + b; in add 20 22        # => 42   (functions are curried)
{ name = "obsernetics"; port = 8080; }.port # => 8080 (attribute sets)
{ a = 1; } // { b = 2; }                    # => { a = 1; b = 2; }
map (x: x * x) [ 1 2 3 4 ]                   # => [ 1 4 9 16 ]
```

## Search and inspect Nixpkgs

```sh
nix search nixpkgs ripgrep
nix eval --raw nixpkgs#ripgrep.version
nix eval --raw nixpkgs#ripgrep.meta.description
```

## Your first derivation

See `greet/default.nix` - a tool built with `writeShellApplication` that pins its
runtime dependency (`hello`) declaratively:

```sh
cd greet
nix-build
./result/bin/greet     # Hello from a reproducible Nix build
```

`result` is a symlink into an immutable `/nix/store/<hash>-greet` path.
