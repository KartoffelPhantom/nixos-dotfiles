 { config, pkgs, ... }:
   {
       # environment packages
  environment.systemPackages = with pkgs; [ 
    btop
    wl-clipboard
    _1password-gui
    fastfetch
    spotify 
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
    wofi
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
    ryubing
    cemu
    librewolf
    protonmail-desktop
    protonup-qt
    lutris
    wine
    qbittorrent-enhanced
    unrar
    python3
    blueman
    vlc
    wl-clipboard
    kdePackages.elisa
    wlr-randr
    mesa
    hyprshot
    osu-lazer
    pkgs.krabby
    gparted
    kdePackages.dolphin
    nwg-look
    win2xcur
    hyprpaper
    feh
];

fonts.packages = with pkgs; [
  dejavu_fonts
  liberation_ttf
  noto-fonts
  fira-code
  nerd-fonts.jetbrains-mono
  noto-fonts-color-emoji
  wqy_zenhei
];


   }

