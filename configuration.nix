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

services.blueman.enable = true;




# i3 config	   
environment.pathsToLink = [ "/libexec" ];

services.xserver = {
  enable = true;

  libinput = {
    enable = true;
    mouse.accelProfile = "flat";         # Disables mouse acceleration
    touchpad.accelProfile = "flat";      # Optional: disables touchpad acceleration
  };

  desktopManager = {
    xterm.enable = false;
  };

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
programs.hyprland.enable = true;

# user config
  users.users.kartoma = {
    isNormalUser = true;
    extraGroups = [ "wheel" "input" "networkmanager" ]; # Enable ‘sudo’ for the user.
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



}
