{ config, pkgs, ... }:

{

  imports =
    [ # Include the results of the hardware scan.
    ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    };

  hardware.xone.enable = true;

  services.xserver.videoDrivers = [ "amdgpu" ];
  environment.systemPackages = with pkgs; [
    lutris
    steam
    streamcontroller
  ];
  services.udev.extraRules = ''
    KERNEL=="uinput", SUBSYSTEM=="misc", OPTIONS+="static_node=uinput", TAG+="uaccess", GROUP="input", MODE="0660"
  '';
  services.pipewire.wireplumber.configPackages = [
  (pkgs.writeTextDir "share/wireplumber/main.lua.d/99-rodecaster.lua" ''
    alsa_monitor.rules = {
      -- Outputs (Sinks)
      {
        matches = {
          {
            { "node.name", "equals", "alsa_output.usb-R__DE_RODECaster_Pro_II_GV0085101-00.pro-output-1" },
          },
        },
        apply_properties = {
          ["node.description"] = "RODECaster Pro II (Main)",
        },
      },
      {
        matches = {
          {
            { "node.name", "equals", "alsa_output.usb-R__DE_RODECaster_Pro_II_GV0085101-00.pro-output-0" },
          },
        },
        apply_properties = {
          ["node.description"] = "RODECaster Pro II (Chat)",
        },
      },
      {
        matches = {
          {
            { "node.name", "equals", "alsa_output.usb-R__DE_R__DECaster_Pro_II_GV0085101-00.pro-output-0" },
          },
        },
        apply_properties = {
          ["node.description"] = "RODECaster Pro II (Secondary)",
        },
      },

      -- Inputs (Sources)
      {
        matches = {
          {
            { "node.name", "equals", "alsa_input.usb-R__DE_RODECaster_Pro_II_GV0085101-00.pro-input-1" },
          },
        },
        apply_properties = {
          ["node.description"] = "RODECaster Pro II (Main)",
        },
      },
      {
        matches = {
          {
            { "node.name", "equals", "alsa_input.usb-R__DE_RODECaster_Pro_II_GV0085101-00.pro-input-0" },
          },
        },
        apply_properties = {
          ["node.description"] = "RODECaster Pro II (Chat)",
        },
      },
      {
        matches = {
          {
            { "node.name", "equals", "alsa_input.usb-R__DE_R__DECaster_Pro_II_GV0085101-00.pro-input-0" },
          },
        },
        apply_properties = {
          ["node.description"] = "RODECaster Pro II (Secondary)",
        },
      },
    }
  '')];
}
