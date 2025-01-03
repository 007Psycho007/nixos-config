{ config, pkgs, ... }:

{
  imports =
    [
      (fetchGit { 
        url = "https://github.com/Exaltia/shadow-nix"; 
        ref = "master"; 
        rev = "b0ceabc3febadc9184e3c50ede8261ddbfdc1808";
      } + "/import/system.nix") #SHADOW
    ];

  programs.shadow-client = {
    enable = true;
    channel = "prod";
  };
  # Hardware hybrid decoding
  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };

  # Hardware drivers
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
      intel-media-driver
    ];
  };
  environment.systemPackages = with pkgs; [
    libva-utils
    libvdpau
  ];
}
