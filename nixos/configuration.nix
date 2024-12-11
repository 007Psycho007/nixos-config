# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, ... }:
let
  vars = import ./vars.nix;
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
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
  networking.nameservers = [ "192.168.0.3" "8.8.8.8" ];
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
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  programs.fish.enable = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.groups.input = {};
  users.users.psycho = {
    isNormalUser = true;
    description = "psycho";
    extraGroups = [ "networkmanager" "wheel" "audio" "docker" "vboxusers" "input"];
    shell = pkgs.fish;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  services.displayManager.defaultSession = "hyprland";


  programs.hyprland = {
    # Install the packages from nixpkgs
    enable = true;
    # Whether to enable XWayland
    xwayland.enable = true;
  };
  services.xserver = {
    enable = true;
    autorun = true;
    desktopManager.xterm.enable = false;
    displayManager.lightdm = {
      enable = true;
      greeters.slick.enable = true;
    };
    windowManager.qtile = {
      enable = true;
      extraPackages = python312Packages: with python312Packages; [
        (qtile-extras.overridePythonAttrs(old: { disabledTestPaths = [ "test/widget/test_strava.py" "test/widget/test_visualiser.py" "test/widget/test_iwd.py" "test/widget/test_upower.py"]; }))
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
#sound.enable = true;
  security.rtkit.enable = true;
  security.pam.services.hyprlock = {};

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
    rofi-wayland
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
    imagemagick
    spectacle
    i3lock-color
    nodejs
    appimage-run
    brightnessctl
    bitwarden-cli
    bitwarden
    obsidian
    ripgrep
    waybar
    walker
    hyprpaper
    kanshi
    ];

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "SourceCodePro" ]; })
    emacs-all-the-icons-fonts
  ];

  security.pki.certificateFiles = [
    certs/internal.pem
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

    services.udev.packages = [ pkgs.nitrokey-udev-rules ];
    programs = {
      ssh.startAgent = false;
      gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
      };
    };

    services.flatpak.enable = true;

    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-wlr ];
    };
  system.stateVersion = "24.05"; # Did you read the comment?
}
