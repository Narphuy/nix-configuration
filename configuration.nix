{ config, pkgs, ... }:

{
  imports = [ # results of hardware scan
      ./hardware-configuration.nix
  ];
  boot.extraModulePackages = [
    config.boot.kernelPackages.rtlwifi_new
  ];

  # systemd boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nix";
  networking.networkmanager.enable = true;

  time.timeZone = "America/New_York";

  # what the fuck is a DHCP
  networking.useDHCP = false;
  networking.interfaces.wlo1.useDHCP = true;

  # locale
  i18n.defaultLocale = "en_US.UTF-8";

  # console
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # x11
  services.xserver = {
    enable = true;

    displayManager = {
      sddm.enable = true;
    };

    desktopManager = {
      plasma5.enable = true;
    };

    layout = "us";
    libinput.enable = true;
  };

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true; # ensuring gtk works
    extraPackages = with pkgs; [
      swaylock
      swayidle
      wl-clipboard
      mako
    ];
  };

  # fonts
  fonts.fonts = with pkgs; [
    nerdfonts
  ];

  # sound
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  users.users.prae = {
    isNormalUser = true;
    description = "Prae";
    extraGroups = [ 
      "wheel"
      "video"
      "networkmanager"
    ];
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    firefox
    brightnessctl
    git
    neofetch
    alacritty
    polybar
    rofi
    waybar
    wofi
    curl
  ];

  # you should probably not change this
  system.stateVersion = "21.11"; # Did you read the comment?
}
