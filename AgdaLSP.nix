{ mkDerivation, aeson, aeson-pretty, Agda, base, bytestring
, co-log-core, containers, criterion, directory, filepath, lens
, lib, lsp, mtl, random, text, unordered-containers
}:
mkDerivation {
  pname = "AgdaLSP";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [
    aeson aeson-pretty Agda base bytestring co-log-core containers
    criterion directory filepath lens lsp mtl random text
    unordered-containers
  ];
  homepage = "https://github.com/githubuser/AgdaLSP#readme";
  license = lib.licenses.bsd3;
  mainProgram = "AgdaLSP";
}
