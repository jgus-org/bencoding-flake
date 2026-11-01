# bencoding-flake

A Nix flake that provides [bencoding](https://pypi.org/project/bencoding/), a pure-Python encoder/decoder for bencode — the serialization format BitTorrent uses for `.torrent` metadata and wire-protocol messages — built from the project's PyPI source distribution.

## Outputs

- `packages.<system>.bencoding` — the bencoding package. The importable module is `bencoding`; upstream ships no command-line interface.
- `packages.<system>.default` — the same derivation.
- `packages.<system>.update-version`, `packages.<system>.update-branches` — maintenance outputs that move the pin. Neither is needed to consume the flake.
- `checks.<system>.formatting`, `formatter` — this repository's own files.

There are no overlays, `nixosModules`, devShells or apps: nothing here installs a service.

## Consuming

```nix
# flake inputs
inputs.bencoding = {
  url = "github:jgus-org/bencoding-flake";
  inputs.nixpkgs.follows = "nixpkgs";
};

# then, as a member of a python environment
inputs.bencoding.packages.${system}.bencoding
```

Following `nixpkgs` is what makes the package usable next to other python code: the derivation is built against that nixpkgs' default CPython, and the package has no runtime dependency of its own, so there is no dependency graph to reconcile.

## Build hosts

`aarch64-darwin`, `aarch64-linux` and `x86_64-linux`, which are flake-lib's default build hosts. bencoding is pure Python with no dependencies, so this closure adds nothing that nixpkgs does not already build.

## What you get

**The version upstream releases, unpatched.** The pin tracks PyPI and the recipe applies no patches. 0.2.6, released 2016-12-02, is the newest release on PyPI.

**The fleet's default build, which this source needs exactly.** The sdist predates `pyproject.toml` — it is a `setup.py` for setuptools — and current nixpkgs builds that through the pyproject machinery with setuptools as the only build-system entry, which is the recipe default; nothing here restates it.

**A check that survives the fleet's test default.** The build verifies the `bencoding` module imports. Upstream's test suite lives in its source repository and is not shipped in the sdist, so no upstream suite is inherited on a bump.
