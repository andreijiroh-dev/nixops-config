{ stdenv, lib, ... }:

stdenv.mkDerivation {
  pname = "coolify-compose";
  version = "0.1.0";

  src = ../scripts/coolify-compose;

  dontUnpack = true;

  installPhase = ''
    runHook preInstall

    install -D -m755 $src $out/bin/coolify-compose

    runHook postInstall
  '';

  meta = with lib; {
    description = "A wrapper script for docker-compose tailored for Coolify deployments.";
    license = licenses.mpl20;
    platforms = platforms.all;
    maintainers = with maintainers; [ ajhalili2006 ];
  };
}