{ ... }:
{
  programs.ssh.extraConfig = ''
  Host eu.nixbuild.net
  PubkeyAcceptedKeyTypes ssh-ed25519
  ServerAliveInterval 60
  IPQoS throughput
  IdentityFile /path/to/your/private/key
  '';

  programs.ssh.knownHosts = {
    nixbuild = {
      hostNames = [ "eu.nixbuild.net" ];
      publicKey = with import ./ssh-keys.nix; hosts.nixbuilds-net;
    };
  };

  nix = {
    distributedBuilds = true;
    buildMachines = [
      { 
        hostName = "eu.nixbuild.net";
        system = "x86_64-linux";
        maxJobs = 100;
        supportedFeatures = [ "benchmark" "big-parallel" ];
      }
      { 
        hostName = "eu.nixbuild.net";
        system = "arm64-linux";
        maxJobs = 100;
        supportedFeatures = [ "benchmark" "big-parallel" ];
      }
    ];
  };  
}