{
  description = "bencoding: tiny Python bencode encoder/decoder used by Kapowarr.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    flake-lib = {
      url = "github:jgus-org/flake-lib/v1";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
  };

  outputs = { self, nixpkgs, flake-utils, flake-lib }:
    flake-lib.lib.mkLeafFlake {
      inherit nixpkgs flake-utils;
      source = { type = "pypi"; pname = "bencoding"; format = "sdist"; };
      package = {
        attr = "bencoding";
        description = "bencoding: tiny Python bencode encoder/decoder used by Kapowarr.";
      };
      pin = import ./pin.nix;
    };
}
