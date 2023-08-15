{ config, pkgs, ... }:

{
  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };
  boot.initrd.luks.devices."luks-6a67d45f-bfa6-4dc8-822b-1bcd224769d7".device = "/dev/disk/by-uuid/6a67d45f-bfa6-4dc8-822b-1bcd224769d7";
  boot.initrd.luks.devices."luks-6a67d45f-bfa6-4dc8-822b-1bcd224769d7".keyFile = "/crypto_keyfile.bin";
}
