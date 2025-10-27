  { config, lib, pkgs, ... }:
   {
       # environment packages
  environment.systemPackages = with pkgs; [
    vim 
    kitty
    btop
    wl-clipboard
    mako
    google-chrome
    _1password-gui
    spotify
    nerd-fonts.jetbrains-mono
    alsa-utils
    tree
    git 
    tealdeer
    legcord
    nh
    nix-output-monitor
    yazi
    gamescope
    pavucontrol
    labymod-launcher
    flameshot
  ];


   }

