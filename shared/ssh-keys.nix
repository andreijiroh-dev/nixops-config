# I managed my public SSH keys via this file, in addition to my GitHub + GitLab + sourcehut accounts if
# you prefer verify commits via SSH over PGP, although I still sign via GPG due to practicality and customs
# in the community. This will be also utilized for managing what SSH keys can have access to secrets encrypted
# via agenix/sops.

{
  # Personal keys
  personal = {
    y2022 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEXuD3hJwInlcHs3wkXWAWNo8es3bPAd2e8ipjyqgGp2 ajhalili2006@andreijiroh.dev (2022 SSH key)";
    passwordless = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDUnTexcVQTGT+UhX8MRPkMvM6FPuskbY2Dn0ScZ3+ot ~ajhalili2006 [passwordless key for sshfs]";
    releases = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHzLVfKtq8vBYeSrrVhwFwkpfu6TDLFgyjb3UmB+Jdhl releases@andreijiroh.dev";
    campus-comlab = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFI1Mj7gTG1IwnxPyr2AsXDq2kBq98hnijhgkGklkhWH halili.459491@meycauayan.sti.edu.ph";
    rp = {
      gildedguy = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCzMlrUe7qMA1P0lP56lq2dKTrwFU6CrVltQ9um+PhOMLkoi31kAlujHtWF6mqGRLXcK0Ao/0Wqug++r82Zu0u7dpAv8LCExtaRRMzagwPkEe4OOqUBOpS6mggfsik8mNA+1UtpkXJ+ZiB4cXtNKEZC0jtxWOTXSV67qgkSxuO+YBWB+7pnESkB0KorqwOoWGGUVfYQtbKUAt6VqM4s6dn7saXqwmN0tCPO6a+4L4mazkYjFD11HhktYsjP9dvnxYSOtMrSFb9JOXRST2LdiIJgwg+HTqBSWGO7aBRHMJaTF3ajlbMtKDQI/EcNQLyGgX6yFdjjzz9DRY+2oU0vPTytdqM2BKsfLlR0GVg7BVL7TZPaLJ1lgpCl4Z1oClW9FOzhnYJVT0W+IKPsnYsFPfv/BVgjWF7YtLdc5zqFJ31PULtikCyd0I6Kt95YD0HdrlR2faWcBHI8KKEAwCCanodGnK/xTOxisTX2dXOxx3mvR/L3Wil2ca5hnD+vt500/o8= gildedguy@andreijiroh";
    };
  };

  # SSHid.io by Termius - https://sshid.io/ajhalili2006
  sshid = {
    personal = {
      zarc = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOU7apiahMdtP1+8dIGUeHuYgWxJYnUdY9nzwMkoyA33  zarc.fawn-cod.ts.net (sshid.io/ajhalili2006)";
      stellapent-cier = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHm3aOTvaREj5QxDtSPR57msq+ZdMyzbqDU8RSIt88Aj stellapent-cier.fawn-cod.ts.net (sshid.io/ajhalili2006)";
    };
    # Guess I am LITERALLY CATCHING STRAYS HERE hehehehehehehehehehehehe
    campus = {
      library = {
        _01 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH+drN3n2XqGXCtVwGlNaDECSpr6M2i03d8X1ktqATj6 STI College Meycauayan - Library Computer 1 (sshid.io/ajhalili2006)";
        _03 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAN42NFlLR9qNGt7Ri4G7g3A9U/Z4WuOaz1nQeclA4DW STI College Meycauayan - Library Computer 3 (sshid.io/ajhalili2006)";
        _04 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH+drN3n2XqGXCtVwGlNaDECSpr6M2i03d8X1ktqATj6 STI College Meycauayan - Library Computer 4 (sshid.io/ajhalili2006)";
        _07 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKq7XqFqcUhmw932vSIKuwwZdC4PG19BPh2SsXvmqPA7 STI College Meycauayan - Library Computer 7 (sshid.io/ajhalili2006)";
      };
      comlab = {
        a-029 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMcJERg5i2CBjoDSSvy2veQKDrUj6z1l3vkxSnziwyhQ STI College Meycauayan - Computer Lab A-029 (sshid.io/ajhalili2006)";
        b-033 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN0qDkS8JP7dtBf5znRlQXTK8QSPDEWgnKaOK+5SlcoR STI College Meycauayan - Computer Lab B-033 (sshid.io/ajhalili2006)";
        b-034_labs = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOSf5bpqdVCYindZBh1DyKbyInFBJ5SFh5Bl+c9++92u STI College Meycauayan - Ubuntu VirtualBox VM Labs (andreijiroh@halili-459491-labs) on Computer Lab B-033 (sshid.io/ajhalili2006)";
      };
    };
  };

  # SSH keys for work, mainly at Recap Time Squad HQ
  work = {
    recaptime-dev = {
      crew = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDEYDna7HlVN6FL+Mxaof+WH5EoVmaUrM7GFAdQSveTJ ajhalili2006@crew.recaptime.dev";
      bot = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICascntXCHIeVcDOlEXFLKH8NXv7ZaF5VABYQDAba/07 service-accounts@recaptime.dev";
    };
  };

  # Infrastructure Operations
  infra = {
    termius = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC+H0oixQCgHiZWk4+H6VupW+2Aibs7poK7kNPf+hJEv";
    gcp = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC9p6XYWUumCEk8ExaoProbI6BQHu52SErSlrOzUzzCUTjRPq2vfENTL7GwG6cgsrDLBxW+u+t6qoTXRVeRc7YCXzmPofls7dy2wXwBSM1Z/AzXCFDEVxtn3Y3F6gLi7nUbMZywBmBSlNjiN1w3FbBKMMP4SYgz0O1SGIjIFBQFheZgRTJxUq9DyPQRbY4U3jcJV8968JPQELKBCvmeI2iKNLOeSY1kVmwwM90yKgcvJsM/uTNXzUjTRK3Y4J0GWA2Up53pQxjmskqOusI+rwDVpnLsJEsjszvpOj5UAQrW4PuhJKjY0RYbigCrqqmCDbFuX9w6N9Sjo6Vp5MVxsMq7OwdNxNhBKDPJ8le4km8hdO8Z162+pSqUftk0hA4OjHIX2/i4avEl6Hh7MD1nbTnTbbaZV+1g6edWCnH0UASnrhulYkUNoWvpAi/bHJsfVuw5tZ8FprI5t6rCKiOXnXqU+jsn+fabDeuIt1mlN7BueebLUzAQ44npsFdSMEDCdJs= gildedguy@stellapent-cier";
    aws = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICx7San3UCFg3+vr5a07MoNBM9egqAeKHnu4Jhpx3Zwx devlab.aws";
  };

  # Hardware-backed SSH keys
  fido2Keys = {
    hackclub_yubikey = {
      main = "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIFCCafMJLzv8vyQ5TCsevYGE6UMZE1puzHtbGslONvvCAAAABHNzaDo= ~ajhalili2006 on YubiKey 5C NFC Hack Club <ajhalili2006@andreijiroh.dev>";
      backup = "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIFlEOSuf1O2/2m60F9BGW8Wyzoef51ycbG4R2TmPVZVbAAAABHNzaDo= ~ajhalili2006 on YubiKey 5C NFC Hack Club - Backup <ajhalili2006@andreijiroh.dev>";
    };
  };

  # Host keys
  hosts = {
    lairland = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMJeo4V8JiW0eLIzmpNB1jdhde0RR5pVOCaSUoBxXces root@lairland.fawn-cod.ts.net";
    stellapent-cier = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHJkAk5TIXkwy9xKPmcyucgbz6SRSG5qhVAPod2nSw1M root@stellapent-cier.fawn-cod.ts.net";
    nixbuilds-net = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPIQCZc54poJ8vqawd8TraNryQeJnvH1eLpIDgbiqymM";
  };
}
