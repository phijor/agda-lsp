{
  description = "AgdaLSP";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";

      pkgs = nixpkgs.legacyPackages.${system};
      AgdaLSP = pkgs.haskellPackages.callPackage ./AgdaLSP.nix { };
    in
    {
      packages.${system} = {
        inherit AgdaLSP;
        default = AgdaLSP;
      };
      devShells.${system}.default = AgdaLSP.env;
    };
}
