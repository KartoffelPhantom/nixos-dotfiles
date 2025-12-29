{ config, lib, pkgs, ...}:
{  
  imports =
    [ 
      /etc/nixos/hardware-configuration.nix
      ./nvidia.nix
      /home/kartoma/dotfiles/packages.nix
  ];

  
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

# shell fish
environment.shells = with pkgs; [ fish ];
users.defaultUserShell = pkgs.fish;
programs.fish.enable = true;

  system.stateVersion = "25.11"; # Did you read the comment?
  

  programs.adb.enable = true;

  systemd.tmpfiles.rules = [
  "f /proc/scsi/scsi 0400 root root -"
];

 

}
