{
  description = "bencoding: a tiny pure-Python bencode encoder/decoder";

  inputs = {
    flake-lib = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:jgus-org/flake-lib/v1";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs =
    {
      self,
      flake-lib,
      nixpkgs,
    }:
    let
      packages =
        {
          buildPackage,
          pkgs,
          ...
        }:
        {
          bencoding = buildPackage {
            meta = {
              description = "bencode encoder/decoder implemented in pure Python.";
              license = pkgs.lib.licenses.mit;
            };
            pname = "bencoding";
            pythonImportsCheck = [ "bencoding" ];
          };
        };
    in
    flake-lib.lib.mkPythonFlake {
      inherit nixpkgs self;
      payload = {
        inherit packages;
        overlays = packages;
      };
      upstream = {
        pin = import ./pin.nix;
        pname = "bencoding";
        type = "pypi";
      };
    };
}
