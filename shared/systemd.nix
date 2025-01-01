{ ... }:

{
  services.timesyncd = {
    enable = true;
    servers = [
      # https://pubfiles.pagasa.dost.gov.ph/tamss/oras/time_synchronization_for_windows_7_and_8.pdf
      "ntp.pagasa.dost.gov.ph"
      # https://www.cloudflare.com/time/
      "time.cloudflare.com"
    ];
    fallbackServers = [
      "0.asia.pool.ntp.org"
      "1.asia.pool.ntp.org"
	    "2.asia.pool.ntp.org"
	    "3.asia.pool.ntp.org"
    ];
  };
}