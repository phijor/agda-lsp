{
  nixpkgs ? import <nixpkgs> { },
}:
nixpkgs.pkgs.haskellPackages.callPackage ./AgdaLSP.nix { }
