{ stdenv, lib, ... }:

stdenv.mkDerivation {
  pname = "ssh-agent-loader";
  version = "0.1.0";

  src = ../misc/bash/lib/ssh-agent-loader;

  dontUnpack = true;

  installPhase = ''
    runHook preInstall

    install -D -m755 $src $out/bin/ssh-agent-loader

    runHook postInstall
  '';

  meta = with lib; {
    description = "A script to reliably detect and switch between SSH agents.";
    license = licenses.mpl20;
    platforms = platforms.all;
    maintainers = with maintainers; [ ajhalili2006 ];
  };
}
