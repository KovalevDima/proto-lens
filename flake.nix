{
  inputs = {
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixpkgs.follows = "unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = {self, flake-parts, nixpkgs, ...} @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux"];
      imports = [];
      perSystem = {self', pkgs, config, lib, ...}:
      {
        devShells = {
          default = pkgs.mkShell {
            buildInputs = with pkgs; [
              haskell.compiler.ghc912
              haskell.packages.ghc912.haskell-language-server
              cabal-install
              haskellPackages.proto-lens-protoc
              haskellPackages.eventlog2html
              protobuf
              nil
            ];
          };
        };
      };
  };
}
