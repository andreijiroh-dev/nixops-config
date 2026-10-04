# Contributing to the project

While this is primarily an personal project for my NixOS setup, community contributions are welcome, especially at utility tooling I wrote in the `misc` directory (e.g. [`detect-vscode-for-git`][dvscfg] and [`ssh-agent-loader`][sal]) and packages I maintain at the `pkgs` directory.

## Prerequisites

Other than the regular "review and agree to the [Community Code of Conduct][ccoc] and [the Linux DCO][dco]", you need the following skills:

* Hands-on experience with writing Nix configs for NixOS/home-manager (using agentic coding tools and looking
  around the web is fine, just make sure to review the outputs, understand it and do test builds before
  submitting a patch) and shell scripting (mainly Bash)

## AI policy

This project uses AI tools primarily for managing NixOS and home-manager configurations and search through documentation, although I do review and test them on my machines and via CI.

See also 

## Sending patches

I do patches mainly at the canonical GitLab project and its Tangled repo, linked in the
README, but feel free to send patches to any of the other repositories as well.

Just don't expect me to merge them but will happily review and merge/adopt them if they are good.

[dvscfg]: ./misc/bash/lib/detect-vscode-for-git
[sal]: ./misc/bash/lib/ssh-agent-loader
[ccoc]: https://policies.recaptime.dev/coc
[dco]: https://policies.recaptime.dev/linux-dco
