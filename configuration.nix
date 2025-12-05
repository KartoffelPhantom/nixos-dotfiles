{ config, lib, pkgs, ... }:
  let
    home-manager = builtins.fetchTarball https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz;
  in
  {
  imports =
    [ 
      /etc/nixos/hardware-configuration.nix
      ./nvidia.nix
      /home/kartoma/dotfiles/packages.nix
	(import "${home-manager}/nixos")
  ];

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
  home-manager.backupFileExtension = "backup";	
  home-manager.users.kartoma = import /home/kartoma/dotfiles/home.nix;
  
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "kys";
  networking.networkmanager.enable = true;
	
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  time.timeZone = "Europe/Berlin";
  

# Bluetooth
hardware.bluetooth = {
  enable = true;
  powerOnBoot = true;
  settings = {
    General = {
      Experimental = true;
      FastConnectable = true;
    };
    Policy = {
      AutoEnable = true;
    };
  };
  input = {
    General = {
      UserspaceHID = true;
    };
  };
};

# services.blueman.enable = true;


# i3 config	   
environment.pathsToLink = [ "/libexec" ];

services.xserver = {
  enable = true;

  libinput = {  # ← Remove "service."
    enable = true;
    mouse.accelProfile = "flat";
    touchpad.accelProfile = "flat";
  };

  desktopManager.xterm.enable = false;

  windowManager.i3 = {
    enable = true;
    extraPackages = with pkgs; [
      dmenu
      i3blocks
      i3status
    ];
  };
};
services.displayManager.defaultSession = "none+i3";
programs.i3lock.enable = true;


# Hyrpland
## programs.hyprland.enable = true;



# Plasma6 try
  services = {
  desktopManager.plasma6.enable = true;

  displayManager.sddm.enable = true;

  displayManager.sddm.wayland.enable = true;
};

environment.systemPackages = with pkgs;
  [
    # KDE
    kdePackages.discover # Optional: Install if you use Flatpak or fwupd firmware update sevice
    kdePackages.kcalc # Calculator
    kdePackages.kcharselect # Tool to select and copy special characters from all installed fonts
    kdePackages.kclock # Clock app
    kdePackages.kcolorchooser # A small utility to select a color
    kdePackages.kolourpaint # Easy-to-use paint program
    kdePackages.ksystemlog # KDE SystemLog Application
    kdePackages.sddm-kcm # Configuration module for SDDM
    kdiff3 # Compares and merges 2 or 3 files or directories
    kdePackages.isoimagewriter # Optional: Program to write hybrid ISO files onto USB disks
    kdePackages.partitionmanager # Optional: Manage the disk devices, partitions and file systems on your computer
    # Non-KDE graphical packages
    hardinfo2 # System information and benchmarks for Linux systems
    vlc # Cross-platform media player and streaming server
    wayland-utils # Wayland utilities
    wl-clipboard # Command-line copy/paste utilities for Wayland
  ];
# user config
  users.users.kartoma = {
    isNormalUser = true;
    extraGroups = [ "wheel" "input" "networkmanager" "adbusers" ]; # Enable ‘sudo’ for the user.
	};



  nixpkgs.config.allowUnfree = true;

# Variables
  environment.sessionVariables = {
     FLAKE = "/home/kartoma/dotfiles";
  };

# Mullvad 
  services.mullvad-vpn.enable = true;
  networking.firewall.allowedTCPPorts = [ 25565 ];

# Steam 
programs.steam = {
  enable = true;
  remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
};
  

  system.stateVersion = "25.05"; # Did you read the comment?
  

  programs.adb.enable = true;

  systemd.tmpfiles.rules = [
  "f /proc/scsi/scsi 0400 root root -"
];

  

}
