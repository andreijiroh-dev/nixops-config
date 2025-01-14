{
  # enable gpg-agent with SSH support
  programs.gnupg.agent = {
     enable = true;
     enableSSHSupport = true;
     enableBrowserSocket = true;
  };
}