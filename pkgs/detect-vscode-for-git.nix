{ stdenv, lib, ... }:

stdenv.mkDerivation {
  pname = "detect-vscode-for-git";
  version = "0.1.0";

  src = ../misc/bash/lib/detect-vscode-for-git;

  dontUnpack = true;

  installPhase = ''
    runHook preInstall

    install -D -m755 $src $out/bin/detect-vscode-for-git

    runHook postInstall
  '';

  meta = with lib; {
    description = "A script to detect and set VS Code as the git editor.";
    license = licenses.mpl20;
    platforms = platforms.all;
    maintainers = with maintainers; [ ajhalili2006 ];
  };
}