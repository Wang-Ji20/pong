{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
  };

  outputs = { self, nixpkgs }:
    let pkgs = nixpkgs.legacyPackages.x86_64-linux.haskellPackages;
    in rec {
      packages.x86_64-linux.hello = pkgs.callCabal2nix "pong" ./. {};
      packages.x86_64-linux.default = self.packages.x86_64-linux.hello;
      devShell.x86_64-linux = pkgs.shellFor {
        packages = p: [ self.packages.x86_64-linux.default ];
        withHoogle = true;
        nativeBuildInputs = with pkgs; [
          haskell-language-server
          ghcid
          cabal-install
        ];
      };
    };
}
