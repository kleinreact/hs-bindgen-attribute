{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
    cargo-sync-readme.url = "github:yvan-sraka/cargo-sync-readme";
  };

  outputs = { self, nixpkgs, utils, cargo-sync-readme }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in {
        devShell = with pkgs;
          mkShell {
            buildInputs = [
              cargo
              cargo-sync-readme.defaultPackage.${system}
              libiconv
              pre-commit
              rust-analyzer
              rustc
              rustfmt
              rustPackages.clippy
            ];
            RUST_SRC_PATH = rustPlatform.rustLibSrc;
          };
      });
}
