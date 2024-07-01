# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let
  vars = import ./vars.nix;
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./home.nix
      ./local.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Setup keyfile

  # Enable swap on luks

  environment.etc = {
	"wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
		bluez_monitor.properties = {
			["bluez5.enable-sbc-xq"] = true,
			["bluez5.enable-msbc"] = true,
			["bluez5.enable-hw-volume"] = true,
			["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
		}
	'';
  };

  networking.hostName = vars.hostName; # Define your hostname.
  networking.nameservers = [ "1.1.1.1" "8.8.88" ];
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  programs.fish.enable = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.psycho = {
    isNormalUser = true;
    description = "psycho";
    extraGroups = [ "networkmanager" "wheel" "audio" "docker" "vboxusers"];
    shell = pkgs.fish;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  services.xserver = {
     enable = true;
     autorun = true;
     displayManager.defaultSession = "none+qtile";
     desktopManager.xterm.enable = false;
     displayManager.lightdm.enable = true;
     windowManager.qtile = {
        enable = true;
        extraPackages = python3Packages: with python3Packages; [
          (qtile-extras.overridePythonAttrs(old: { disabledTestPaths = [ "test/widget/test_strava.py" "test/widget/test_visualiser.py" ]; }))
	      ];
     };
  };

  hardware.bluetooth = {
    enable = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
      };
    };
  };
  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit =true;
    pulse.enable = true;
    wireplumber.enable = true;
  }; 
  
  services.picom.enable = true;

  services.blueman.enable = true;

  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    nyxt
    wget
    zsh
    firefox
    rofi
    feh
    git
    jq
    cmake
    gnumake
    gcc
    libtool
    any-nix-shell
    xclip
    bluez
    pavucontrol
    playerctl
    virt-manager
    imagemagick
    spectacle
    i3lock-color
    nodejs
    spotify-tui
    appimage-run
    brightnessctl
    bitwarden-cli
    ];

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "SourceCodePro" ]; })
    emacs-all-the-icons-fonts
  ];

  virtualisation = {
      podman = {
        enable = true;
        dockerCompat = true;
        defaultNetwork.settings = {
          dns_enabled = true;
        };
      };
      virtualbox.host = {
        enable = true;
      };
    };

    services.emacs = {
      enable = true;
      package = pkgs.emacs;
    };

    services.spotifyd = {
      enable = true;
      settings = {
        global = {
          username = "1163141852";
          password_cmd = "cat /Keys/spotify-password.txt";
          backend = "pulseaudio";
        };
      };
    };

  system.stateVersion = "23.11"; # Did you read the comment?
}
