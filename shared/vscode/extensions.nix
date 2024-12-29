{ pkgs, lib }:

let
  inherit (pkgs.stdenv) isDarwin isLinux isi686 isx86_64 isAarch32 isAarch64;
  vscode-utils = pkgs.vscode-utils;
  merge = lib.attrsets.recursiveUpdate;
in
merge
  (merge
    (merge
      (merge
      {
        "ms-python"."vscode-pylance" = vscode-utils.extensionFromVscodeMarketplace {
          name = "vscode-pylance";
          publisher = "ms-python";
          version = "2024.12.100";
          sha256 = "167cj9r476whfjg474s4nf7zi8v7cj58vrqiw86y4vcgl57v4h50";
        };
        "esbenp"."prettier-vscode" = vscode-utils.extensionFromVscodeMarketplace {
          name = "prettier-vscode";
          publisher = "esbenp";
          version = "11.0.0";
          sha256 = "1fcz8f4jgnf24kblf8m8nwgzd5pxs2gmrv235cpdgmqz38kf9n54";
        };
        "ms-azuretools"."vscode-docker" = vscode-utils.extensionFromVscodeMarketplace {
          name = "vscode-docker";
          publisher = "ms-azuretools";
          version = "1.29.3";
          sha256 = "1j35yr8f0bqzv6qryw0krbfigfna94b519gnfy46sr1licb6li6g";
        };
        "dbaeumer"."vscode-eslint" = vscode-utils.extensionFromVscodeMarketplace {
          name = "vscode-eslint";
          publisher = "dbaeumer";
          version = "3.0.13";
          sha256 = "0yjrylvkw5q9w7kjigndm5m66qn8nranrm0m7qna8ggi0f2nz5cp";
        };
        "eamodio"."gitlens" = vscode-utils.extensionFromVscodeMarketplace {
          name = "gitlens";
          publisher = "eamodio";
          version = "2024.12.2404";
          sha256 = "0wc0hqaxf5sh9wjsx29mnl6i8bf2jhsi4a1hshwiwm08p6lhg4fv";
        };
        "pkief"."material-icon-theme" = vscode-utils.extensionFromVscodeMarketplace {
          name = "material-icon-theme";
          publisher = "pkief";
          version = "5.16.0";
          sha256 = "0ggwj2y84dyqhzl9kisddx64559bkhnfv94zxz6zcqyfq0vpycng";
        };
        "github"."vscode-pull-request-github" = vscode-utils.extensionFromVscodeMarketplace {
          name = "vscode-pull-request-github";
          publisher = "github";
          version = "0.103.2024121117";
          sha256 = "0k90870ra85np0dg19mx2blr1yg9i2sk25mx08bblqh0hh0s5941";
        };
        "github"."copilot" = vscode-utils.extensionFromVscodeMarketplace {
          name = "copilot";
          publisher = "github";
          version = "1.254.1278";
          sha256 = "0n55apya8q87l4ijfvj3qqwg6sij1k9is99zc2wffgmghqb9fv7l";
        };
        "wakatime"."vscode-wakatime" = vscode-utils.extensionFromVscodeMarketplace {
          name = "vscode-wakatime";
          publisher = "wakatime";
          version = "25.0.0";
          sha256 = "1c5ilsj8zvcrhvh3gb9wbgz8llfkjgxnv39r12a3iyy3fvdg5zlz";
        };
        "github"."copilot-chat" = vscode-utils.extensionFromVscodeMarketplace {
          name = "copilot-chat";
          publisher = "github";
          version = "0.24.2024121201";
          sha256 = "14cs1ncbv0fib65m1iv6njl892p09fmamjkfyxrsjqgks2hisz5z";
        };
        "xabikos"."javascriptsnippets" = vscode-utils.extensionFromVscodeMarketplace {
          name = "javascriptsnippets";
          publisher = "xabikos";
          version = "1.8.0";
          sha256 = "19xg24alxsvq8pvafprshg7qxzx8p37bzk7qz6kjgkpvandrdpl6";
        };
        "github"."github-vscode-theme" = vscode-utils.extensionFromVscodeMarketplace {
          name = "github-vscode-theme";
          publisher = "github";
          version = "6.3.5";
          sha256 = "0jj7bp5iadrm2h75pdn96z0wzygv0sfa93karvlqlwagh2hrvrkl";
        };
        "golang"."go" = vscode-utils.extensionFromVscodeMarketplace {
          name = "go";
          publisher = "golang";
          version = "0.45.0";
          sha256 = "1ihy5pd5ymxarcgnq8ky7nfa9kk9x3hdazajirrh5f1m4cwgizn3";
        };
        "donjayamanne"."githistory" = vscode-utils.extensionFromVscodeMarketplace {
          name = "githistory";
          publisher = "donjayamanne";
          version = "0.6.20";
          sha256 = "0x9q7sh5l1frpvfss32ypxk03d73v9npnqxif4fjwcfwvx5mhiww";
        };
        "streetsidesoftware"."code-spell-checker" = vscode-utils.extensionFromVscodeMarketplace {
          name = "code-spell-checker";
          publisher = "streetsidesoftware";
          version = "4.0.29";
          sha256 = "1vx7qs66vbkshig029qgxmcx1shg5hkjkj7bd693hzfhz8702krs";
        };
        "editorconfig"."editorconfig" = vscode-utils.extensionFromVscodeMarketplace {
          name = "editorconfig";
          publisher = "editorconfig";
          version = "0.16.4";
          sha256 = "0fa4h9hk1xq6j3zfxvf483sbb4bd17fjl5cdm3rll7z9kaigdqwg";
        };
        "bradlc"."vscode-tailwindcss" = vscode-utils.extensionFromVscodeMarketplace {
          name = "vscode-tailwindcss";
          publisher = "bradlc";
          version = "0.13.64";
          sha256 = "14962pavlbdmqki6m7y7k9nvz1pcicrn3dw10lrcq8vxbj2bc416";
        };
        "davidanson"."vscode-markdownlint" = vscode-utils.extensionFromVscodeMarketplace {
          name = "vscode-markdownlint";
          publisher = "davidanson";
          version = "0.57.0";
          sha256 = "1gsc3xsvy4qbz75frk6jjf2f95b0frmbclhgxi1j49zbh16y2b76";
        };
        "mikestead"."dotenv" = vscode-utils.extensionFromVscodeMarketplace {
          name = "dotenv";
          publisher = "mikestead";
          version = "1.0.1";
          sha256 = "0rs57csczwx6wrs99c442qpf6vllv2fby37f3a9rhwc8sg6849vn";
        };
        "github"."codespaces" = vscode-utils.extensionFromVscodeMarketplace {
          name = "codespaces";
          publisher = "github";
          version = "1.17.3";
          sha256 = "1g4b7gd24cifmh62v1dj1b79yp5z6jbffmwh2nlymjbqf9h4bll9";
        };
        "mtxr"."sqltools" = vscode-utils.extensionFromVscodeMarketplace {
          name = "sqltools";
          publisher = "mtxr";
          version = "0.28.3";
          sha256 = "0zs8gdfar6g7j1mybdrpx7rmydlb1smqicw9438hrfzw301cffkd";
        };
        "codezombiech"."gitignore" = vscode-utils.extensionFromVscodeMarketplace {
          name = "gitignore";
          publisher = "codezombiech";
          version = "0.9.0";
          sha256 = "0ww0x28m83fv5zdqkmz108rsxb60fyy5y0ksknb2xchirzwhayi0";
        };
        "github"."remotehub" = vscode-utils.extensionFromVscodeMarketplace {
          name = "remotehub";
          publisher = "github";
          version = "0.65.2024112101";
          sha256 = "0mbw1nzvf8ch55vq0lsf0qpfl1dgyk5y80pca81j9dplyz4vrgax";
        };
        "ms-vscode"."remote-repositories" = vscode-utils.extensionFromVscodeMarketplace {
          name = "remote-repositories";
          publisher = "ms-vscode";
          version = "0.43.2024112101";
          sha256 = "1mss2fkpx21dm5rlnbhqw7japxz4k22grrv66ja34fl9fbqli9zw";
        };
        "github"."vscode-github-actions" = vscode-utils.extensionFromVscodeMarketplace {
          name = "vscode-github-actions";
          publisher = "github";
          version = "0.27.0";
          sha256 = "0sk8cgnk4pyjxwfi3hr3qrajffvdncvq3xbjn73g3jz0ygakg7xi";
        };
        "ms-vscode"."azure-repos" = vscode-utils.extensionFromVscodeMarketplace {
          name = "azure-repos";
          publisher = "ms-vscode";
          version = "0.41.2024112101";
          sha256 = "1dgyr1zmrl1aihlsfn0grrysmzf4g47m968zdn7fyc17hl857r59";
        };
        "orta"."vscode-jest" = vscode-utils.extensionFromVscodeMarketplace {
          name = "vscode-jest";
          publisher = "orta";
          version = "6.4.0";
          sha256 = "0asjg2ycq20qg2zyxybnmas2br08mjwhsw03y0qz24g8rkn9a7s4";
        };
        "tamasfe"."even-better-toml" = vscode-utils.extensionFromVscodeMarketplace {
          name = "even-better-toml";
          publisher = "tamasfe";
          version = "0.21.2";
          sha256 = "0208cms054yj2l8pz9jrv3ydydmb47wr4i0sw8qywpi8yimddf11";
        };
        "bierner"."markdown-mermaid" = vscode-utils.extensionFromVscodeMarketplace {
          name = "markdown-mermaid";
          publisher = "bierner";
          version = "1.27.0";
          sha256 = "1c9nvi2r3frbyi2ygff2zh3ylvr4df585mb6b5r8n6g5aa9kzp6k";
        };
        "prisma"."prisma" = vscode-utils.extensionFromVscodeMarketplace {
          name = "prisma";
          publisher = "prisma";
          version = "6.1.0";
          sha256 = "1m4i60hm62m1bl6nn4pk0l54ph7zf0c3ppvx4qc4bwpqv82k7xv1";
        };
        "bierner"."markdown-preview-github-styles" = vscode-utils.extensionFromVscodeMarketplace {
          name = "markdown-preview-github-styles";
          publisher = "bierner";
          version = "2.1.0";
          sha256 = "1fn9gdf3xj1drch4djn6c9lg94i2r9yjpfrf1a0y4v8q2zjk8sz8";
        };
        "gitlab"."gitlab-workflow" = vscode-utils.extensionFromVscodeMarketplace {
          name = "gitlab-workflow";
          publisher = "gitlab";
          version = "5.26.0";
          sha256 = "1xb8a834bgblc4zcrdc9v3by3wv3fls3bz3bm7rxaqyvszlpb42d";
        };
        "bierner"."markdown-emoji" = vscode-utils.extensionFromVscodeMarketplace {
          name = "markdown-emoji";
          publisher = "bierner";
          version = "0.3.1";
          sha256 = "0409sks7zz0lp1a0x6nxsh11yfnnb36s802q6dwfwjnblp049xw1";
        };
        "denoland"."vscode-deno" = vscode-utils.extensionFromVscodeMarketplace {
          name = "vscode-deno";
          publisher = "denoland";
          version = "3.43.1";
          sha256 = "0lna1znrbsdggzp6mx079461p21ngwgqz6mb7i3d0bnpxb844x3a";
        };
        "bierner"."markdown-checkbox" = vscode-utils.extensionFromVscodeMarketplace {
          name = "markdown-checkbox";
          publisher = "bierner";
          version = "0.4.0";
          sha256 = "0jbfi0av84ixwhcpysh9gyrsfxpy65igiidrdarn7vgsvxsdr0q2";
        };
        "unifiedjs"."vscode-mdx" = vscode-utils.extensionFromVscodeMarketplace {
          name = "vscode-mdx";
          publisher = "unifiedjs";
          version = "1.8.12";
          sha256 = "0afzx5i6bw7hmm4f8vdvx6a6mx053gmvc0gn78fz94b6fyaijsl7";
        };
        "bierner"."emojisense" = vscode-utils.extensionFromVscodeMarketplace {
          name = "emojisense";
          publisher = "bierner";
          version = "0.10.0";
          sha256 = "14rb8licb32rh04g7lq73lmfx4pk2p4x63427l3s9fw9idsiwgrw";
        };
        "bierner"."markdown-yaml-preamble" = vscode-utils.extensionFromVscodeMarketplace {
          name = "markdown-yaml-preamble";
          publisher = "bierner";
          version = "0.1.0";
          sha256 = "1xlb6dvrsy2sp92lax1nq01xcrax1nm256ns9b4vvkq7p4njpqp5";
        };
        "bierner"."markdown-footnotes" = vscode-utils.extensionFromVscodeMarketplace {
          name = "markdown-footnotes";
          publisher = "bierner";
          version = "0.1.1";
          sha256 = "1pp64x8cn4vmpscmzv2dg6bakjhnwd36rms2wl6bs5laq29k5wl7";
        };
        "bierner"."github-markdown-preview" = vscode-utils.extensionFromVscodeMarketplace {
          name = "github-markdown-preview";
          publisher = "bierner";
          version = "0.3.0";
          sha256 = "124vsg5jxa90j3mssxi18nb3wn6fji6b0mnnkasa89rgx3jfb5pf";
        };
        "pkief"."material-product-icons" = vscode-utils.extensionFromVscodeMarketplace {
          name = "material-product-icons";
          publisher = "pkief";
          version = "1.7.1";
          sha256 = "1g75m55fc6nnfazpgmjxc48kw8abv85sglmmmjglwwgwi0di2xlj";
        };
        "vivaxy"."vscode-conventional-commits" = vscode-utils.extensionFromVscodeMarketplace {
          name = "vscode-conventional-commits";
          publisher = "vivaxy";
          version = "1.26.0";
          sha256 = "1n414wwd6my4xjmh55b6l0s8bqadnq35ya1isxvdi6yabapbwg9f";
        };
        "coolbear"."systemd-unit-file" = vscode-utils.extensionFromVscodeMarketplace {
          name = "systemd-unit-file";
          publisher = "coolbear";
          version = "1.0.6";
          sha256 = "0sc0zsdnxi4wfdlmaqwb6k2qc21dgwx6ipvri36x7agk7m8m4736";
        };
        "ms-vscode"."wordcount" = vscode-utils.extensionFromVscodeMarketplace {
          name = "wordcount";
          publisher = "ms-vscode";
          version = "0.1.0";
          sha256 = "164s721bqbw2lh770vli9vij8q79033nd5k1acxwadmlf99hmgj1";
        };
        "ms-vscode"."vscode-github-issue-notebooks" = vscode-utils.extensionFromVscodeMarketplace {
          name = "vscode-github-issue-notebooks";
          publisher = "ms-vscode";
          version = "0.0.130";
          sha256 = "0g82z1qpj1abfykflk0yq0j40mqwfkxk7sx0ms9q7wa2yblwj1fk";
        };
        "exiasr"."hadolint" = vscode-utils.extensionFromVscodeMarketplace {
          name = "hadolint";
          publisher = "exiasr";
          version = "1.1.2";
          sha256 = "00x6bnjm0yk0fcw91c47g8c5shgbcvxyyz49r4y23q4gqizvaqz8";
        };
        "drknoxy"."eslint-disable-snippets" = vscode-utils.extensionFromVscodeMarketplace {
          name = "eslint-disable-snippets";
          publisher = "drknoxy";
          version = "1.4.1";
          sha256 = "1djjknfg81cjbn4bcalc7gg9fha5lzwmpmmrzm68n87qvld58hs4";
        };
        "leighlondon"."eml" = vscode-utils.extensionFromVscodeMarketplace {
          name = "eml";
          publisher = "leighlondon";
          version = "0.4.0";
          sha256 = "180gis04nisccr9l4ibks5fn2gp327b9bmwjiap81lir859kkrzv";
        };
        "jnoortheen"."nix-ide" = vscode-utils.extensionFromVscodeMarketplace {
          name = "nix-ide";
          publisher = "jnoortheen";
          version = "0.3.5";
          sha256 = "12sg67mn3c8mjayh9d6y8qaky00vrlnwwx58v1f1m4qrbdjqab46";
        };
        "matthewpi"."caddyfile-support" = vscode-utils.extensionFromVscodeMarketplace {
          name = "caddyfile-support";
          publisher = "matthewpi";
          version = "0.4.0";
          sha256 = "1fjhirybvb92frqj1ssh49a73q497ny69z9drdjlkpaccpbvb0r7";
        };
        "ultram4rine"."vscode-choosealicense" = vscode-utils.extensionFromVscodeMarketplace {
          name = "vscode-choosealicense";
          publisher = "ultram4rine";
          version = "0.9.4";
          sha256 = "1hs8sjbq9rvs8wkaxx9nh9swbdca9rfkamf2mcvp3gyw7d5park2";
        };
        "tailscale"."vscode-tailscale" = vscode-utils.extensionFromVscodeMarketplace {
          name = "vscode-tailscale";
          publisher = "tailscale";
          version = "1.0.0";
          sha256 = "0j41xbz6zangq7i4mj4xgdpsswss3jnznyd9v3943yvfhmkq5a1h";
        };
        "wdhongtw"."gpg-indicator" = vscode-utils.extensionFromVscodeMarketplace {
          name = "gpg-indicator";
          publisher = "wdhongtw";
          version = "0.7.2";
          sha256 = "0sfn2lvj2a7kwkbjpswbl9hwhpcv053gnxny5x5rhsqcsq2nx8yk";
        };
        "r3inbowari"."gomodexplorer" = vscode-utils.extensionFromVscodeMarketplace {
          name = "gomodexplorer";
          publisher = "r3inbowari";
          version = "0.3.18";
          sha256 = "1k0assbxwakbsxfp5d2kcq1pfg3rzdmzc96d7qgrhrp9lx22n8p9";
        };
        "doppler"."doppler-vscode" = vscode-utils.extensionFromVscodeMarketplace {
          name = "doppler-vscode";
          publisher = "doppler";
          version = "0.0.10";
          sha256 = "1cqaxnf45in44i4za36diirgh1q5rkmk27is9h6zgnmgl2i9awa7";
        };
        "yahyabatulu"."vscode-markdown-alert" = vscode-utils.extensionFromVscodeMarketplace {
          name = "vscode-markdown-alert";
          publisher = "yahyabatulu";
          version = "0.0.4";
          sha256 = "1b4ngq3hn362ngdybjazr0x73whr7p5sbxms80s8mdd7yhq949kl";
        };
        "martellaj"."license-injector" = vscode-utils.extensionFromVscodeMarketplace {
          name = "license-injector";
          publisher = "martellaj";
          version = "0.0.2";
          sha256 = "09d9bbd5drp3krla2q37dp4rrz4mb20mnsrkjpb00n1mvf7q1fps";
        };
        "codiium"."wrangler" = vscode-utils.extensionFromVscodeMarketplace {
          name = "wrangler";
          publisher = "codiium";
          version = "0.0.1";
          sha256 = "1g2wx6ln2kym2daqgc3nxw995rb1c1n7j3gqj0vfbk520qp4vhfx";
        };
        "joel-harkes"."emlviewer" = vscode-utils.extensionFromVscodeMarketplace {
          name = "emlviewer";
          publisher = "joel-harkes";
          version = "0.0.4";
          sha256 = "08rh5j50jkhcywkngf493cdim15f6vbj08av6m1cvp0v3ha21vdq";
        };
        "aikebang"."mkdocs-syntax-highlight" = vscode-utils.extensionFromVscodeMarketplace {
          name = "mkdocs-syntax-highlight";
          publisher = "aikebang";
          version = "0.2.1";
          sha256 = "1gpcjdcf9yr263cql14wwyw2f5fsq06i2bsr8nja0izyw76g8wvm";
        };
        "devfile"."vscode-devfile" = vscode-utils.extensionFromVscodeMarketplace {
          name = "vscode-devfile";
          publisher = "devfile";
          version = "0.0.2";
          sha256 = "156vq1gr7x94nrjlgv1a5qz0r8k5vh9y9hz1f0jaxcjcynjp4ijs";
        };
      }
        (lib.attrsets.optionalAttrs (isLinux && (isi686 || isx86_64)) {
          "ms-python"."python" = vscode-utils.extensionFromVscodeMarketplace {
            name = "python";
            publisher = "ms-python";
            version = "2024.23.2024121901";
            sha256 = "01wfhbaq9v2wvnndh6dphq1f6c04dg0yx9p7637v9bl124zm0qw7";
            arch = "linux-x64";
          };
          "timonwong"."shellcheck" = vscode-utils.extensionFromVscodeMarketplace {
            name = "shellcheck";
            publisher = "timonwong";
            version = "0.37.1";
            sha256 = "13gdyiafqla7dra17q842d8a7vrgmf0im4z6qm6xzgim71qzcqhy";
            arch = "linux-x64";
          };
        }))
      (lib.attrsets.optionalAttrs (isLinux && (isAarch32 || isAarch64)) {
        "ms-python"."python" = vscode-utils.extensionFromVscodeMarketplace {
          name = "python";
          publisher = "ms-python";
          version = "2024.23.2024121901";
          sha256 = "1qs14aca323yqc93rrnwvp7v40k9z2500lj9pkh5sa2pfm9cl68x";
          arch = "linux-arm64";
        };
        "timonwong"."shellcheck" = vscode-utils.extensionFromVscodeMarketplace {
          name = "shellcheck";
          publisher = "timonwong";
          version = "0.37.1";
          sha256 = "1xp4qyrs8rcaba94nm26da0lf0qjbchp218jm4iyczg5dpgvp6hk";
          arch = "linux-arm64";
        };
      }))
    (lib.attrsets.optionalAttrs (isDarwin && (isi686 || isx86_64)) {
      "ms-python"."python" = vscode-utils.extensionFromVscodeMarketplace {
        name = "python";
        publisher = "ms-python";
        version = "2024.23.2024121901";
        sha256 = "0jh7rkh5j2l8irb2d43hy9n5kw59czyijsiq5f9641rfl6yvakzh";
        arch = "darwin-x64";
      };
      "timonwong"."shellcheck" = vscode-utils.extensionFromVscodeMarketplace {
        name = "shellcheck";
        publisher = "timonwong";
        version = "0.37.1";
        sha256 = "0jvi9pzw80ga47p9zy92wy43prci5dj8lfa5syxl5cvchd3848v1";
        arch = "darwin-x64";
      };
    }))
  (lib.attrsets.optionalAttrs (isDarwin && (isAarch32 || isAarch64)) {
    "ms-python"."python" = vscode-utils.extensionFromVscodeMarketplace {
      name = "python";
      publisher = "ms-python";
      version = "2024.23.2024121901";
      sha256 = "1d0w7ih58bg1smmjp3i798qbf08maqa3m263ygvllyawy3kl03qr";
      arch = "darwin-arm64";
    };
    "timonwong"."shellcheck" = vscode-utils.extensionFromVscodeMarketplace {
      name = "shellcheck";
      publisher = "timonwong";
      version = "0.37.1";
      sha256 = "0l72fmphy7v86jdlbk4xclaxm6g2mc2cd3jcydwrnwyfagh2n9di";
      arch = "darwin-arm64";
    };
  })
