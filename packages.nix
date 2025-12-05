 { config, pkgs, ... }:
   {
       # environment packages
  environment.systemPackages = with pkgs; [ 
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
    nix-output-monitor
    yazi
    gamescope
    pavucontrol
    labymod-launcher
    flameshot
    wofi
    bemenu
    vulkan-loader
    vulkan-tools
    prismlauncher
    unp
    zulu8
    zulu17
    zulu21
    zenity
    zip
    ungoogled-chromium
    xorg.xhost
    neovim
    wget
    scrcpy
    alsa-lib
    alsa-plugins
    lunar-client
    ocs-url
    rescrobbled
    playerctl
    tree
  ];


   }

