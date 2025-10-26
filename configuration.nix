{ config, lib, pkgs, ... }:
let
  home-manager = builtins.fetchTarball https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz;
in
{
  imports =
    [ 
      /etc/nixos/hardware-configuration.nix
      ./nvidia.nix
	      (import "${home-manager}/nixos")
	    ];

	home-manager.useUserPackages = true;
	home-manager.useGlobalPkgs = true;
	home-manager.backupFileExtension = "backup";
	home-manager.users.kartoma = import ./home.nix;

	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	  networking.hostName = "kys";
	  networking.networkmanager.enable = true;
	  
	  nix.settings.experimental-features = [ "nix-command" "flakes" ];

	  time.timeZone = "Europe/Berlin";

	   services.xserver = {
	     enable = true;
	  
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

	   users.users.kartoma = {
	     isNormalUser = true;
	     extraGroups = [ "wheel" "input" "networkmanager" ]; # Enable ‘sudo’ for the user.
	   };


	   nixpkgs.config.allowUnfree = true;

	   environment.systemPackages = with pkgs; [
	     vim 
	     kitty
	     btop
	     fastfetch
	     wl-clipboard
     mako
     google-chrome
     _1password-gui
     spotify
     nerd-fonts.jetbrains-mono
     alsa-utils
     tree
     neovim
     git 
     tealdeer
     bat
     legcord
 ];


   system.stateVersion = "25.05"; # Did you read the comment?

}

