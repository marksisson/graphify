# sample.nix - fixture for graphify nix extractor tests
{ pkgs ? import <nixpkgs> {} }:

let
  version = "1.0.0";
  pname = "sample-pkg";

  helperFn = x: x + 1;

  buildConfig = {
    debug = false;
    optimize = true;
  };

in

{
  myPackage = pkgs.stdenv.mkDerivation {
    inherit pname version;
    src = ./src;
    buildInputs = [ pkgs.curl pkgs.openssl ];
    buildPhase = ''
      echo "Building"
    '';
  };

  devShell = pkgs.mkShell {
    buildInputs = [ pkgs.git pkgs.nodejs ];
    shellHook = ''
      echo "Welcome"
    '';
  };

  utils = {
    double = n: helperFn (helperFn n);
    greet = name: "Hello, ${name}";
  };
}
