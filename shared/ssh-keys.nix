# I managed my public SSH keys via this file, in addition to my GitHub + GitLab + sourcehut accounts if
# you prefer verify commits via SSH over PGP, although I still sign via GPG due to practicality and customs
# in the community. This will be also utilized for managing what SSH keys can have access to secrets encrypted
# via agenix/sops.

{
  personal = {
    y2022 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEXuD3hJwInlcHs3wkXWAWNo8es3bPAd2e8ipjyqgGp2 ajhalili2006@andreijiroh.dev";
    passwordless = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDUnTexcVQTGT+UhX8MRPkMvM6FPuskbY2Dn0ScZ3+ot ~ajhalili2006 [passwordless key for sshfs]";
    releases = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHzLVfKtq8vBYeSrrVhwFwkpfu6TDLFgyjb3UmB+Jdhl releases@andreijiroh.dev";
    campus-comlab = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFI1Mj7gTG1IwnxPyr2AsXDq2kBq98hnijhgkGklkhWH";
    rp = {
      gildedguy = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCzMlrUe7qMA1P0lP56lq2dKTrwFU6CrVltQ9um+PhOMLkoi31kAlujHtWF6mqGRLXcK0Ao/0Wqug++r82Zu0u7dpAv8LCExtaRRMzagwPkEe4OOqUBOpS6mggfsik8mNA+1UtpkXJ+ZiB4cXtNKEZC0jtxWOTXSV67qgkSxuO+YBWB+7pnESkB0KorqwOoWGGUVfYQtbKUAt6VqM4s6dn7saXqwmN0tCPO6a+4L4mazkYjFD11HhktYsjP9dvnxYSOtMrSFb9JOXRST2LdiIJgwg+HTqBSWGO7aBRHMJaTF3ajlbMtKDQI/EcNQLyGgX6yFdjjzz9DRY+2oU0vPTytdqM2BKsfLlR0GVg7BVL7TZPaLJ1lgpCl4Z1oClW9FOzhnYJVT0W+IKPsnYsFPfv/BVgjWF7YtLdc5zqFJ31PULtikCyd0I6Kt95YD0HdrlR2faWcBHI8KKEAwCCanodGnK/xTOxisTX2dXOxx3mvR/L3Wil2ca5hnD+vt500/o8= gildedguy@andreijiroh";
    };
    sshid = {
      tbd = "tbd";
    };
  };

  work = {
    recaptime-dev = {
      crew = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDEYDna7HlVN6FL+Mxaof+WH5EoVmaUrM7GFAdQSveTJ ajhalili2006@crew.recaptime.dev";
      bot = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICascntXCHIeVcDOlEXFLKH8NXv7ZaF5VABYQDAba/07 service-accounts@recaptime.dev";
    };
  };

  infra = {
    termius = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC+H0oixQCgHiZWk4+H6VupW+2Aibs7poK7kNPf+hJEv";
    gcp = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC9p6XYWUumCEk8ExaoProbI6BQHu52SErSlrOzUzzCUTjRPq2vfENTL7GwG6cgsrDLBxW+u+t6qoTXRVeRc7YCXzmPofls7dy2wXwBSM1Z/AzXCFDEVxtn3Y3F6gLi7nUbMZywBmBSlNjiN1w3FbBKMMP4SYgz0O1SGIjIFBQFheZgRTJxUq9DyPQRbY4U3jcJV8968JPQELKBCvmeI2iKNLOeSY1kVmwwM90yKgcvJsM/uTNXzUjTRK3Y4J0GWA2Up53pQxjmskqOusI+rwDVpnLsJEsjszvpOj5UAQrW4PuhJKjY0RYbigCrqqmCDbFuX9w6N9Sjo6Vp5MVxsMq7OwdNxNhBKDPJ8le4km8hdO8Z162+pSqUftk0hA4OjHIX2/i4avEl6Hh7MD1nbTnTbbaZV+1g6edWCnH0UASnrhulYkUNoWvpAi/bHJsfVuw5tZ8FprI5t6rCKiOXnXqU+jsn+fabDeuIt1mlN7BueebLUzAQ44npsFdSMEDCdJs= gildedguy@stellapent-cier";
    aws = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICx7San3UCFg3+vr5a07MoNBM9egqAeKHnu4Jhpx3Zwx devlab.aws";
  };
  
  hosts = {
    lairland = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMJeo4V8JiW0eLIzmpNB1jdhde0RR5pVOCaSUoBxXces root@lairland.fawn-cod.ts.net";
    stellapent-cier = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHJkAk5TIXkwy9xKPmcyucgbz6SRSG5qhVAPod2nSw1M root@stellapent-cier.fawn-cod.ts.net";
  };
}
