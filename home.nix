{ config, pkgs, ... }:

{
  # ... other configuration
  home.username = "kartoma";
  home.homeDirectory = "/home/kartoma";
  home.stateVersion = "25.11";

  programs.bash = {
    enable = true;
    shellAliases = {
      btw = "echo I wanna end it all";
      nrs = "cd /home/kartoma/dotfiles && sudo nixos-rebuild switch --impure --flake .#kys";
      nrsu = "cd /home/kartoma/dotfiles && sudo nix flake update && sudo nixos-rebuild switch --impure --flake .#kys";
      c = "clear && fastfetch";
    };

    initExtra = ''
      PS1='\[\e[38;5;172;2m\][\[\e[0;38;5;221m\]\u\[\e[0m\] in \[\e[38;5;222;2m\]\w\[\e[38;5;172m\]]\[\e[0m\] \\$ '
      fastfetch
    '';
  };
  
  #Configs 
  home.file.".config/i3/config".source = /home/kartoma/dotfiles/i3/config;
  home.file.".config/i3/mouse.sh".source = /home/kartoma/dotfiles/i3/mouse.sh;
  home.file.".config/kitty/kitty.conf".source = /home/kartoma/dotfiles/kitty/kitty.conf;
  home.file.".config/kitty/current-theme.conf".source = /home/kartoma/dotfiles/kitty/current-theme.conf;
  home.file.".config/btop/btop.conf".source = /home/kartoma/dotfiles/btop/btop.conf;
  home.file.".config/hypr/hyprland.conf".source = /home/kartoma/dotfiles/hypr/hyprland.conf;
  home.file.".config/legcord/userAssets/Minecraft.ttf".source = /home/kartoma/dotfiles/legcord/Minecraft.ttf;



  home.packages = with pkgs; [
    bat
    fastfetch
    feh
  ];

  # This is the new section for the feh command
  systemd.user.services."wallpaper-feh" = {
    Unit = {
      Description = "Set wallpaper with feh";
      # Ensure this service starts with the graphical session.
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      Type = "oneshot"; # A one-time command
      # Use the feh from the Nix store and the homeDirectory variable.
      # The full path is more reliable in the systemd environment.
      ExecStart = "${pkgs.feh}/bin/feh --bg-fill ${config.home.homeDirectory}/dotfiles/i3/ALLqk82.png";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
  home.sessionVariables.PATH = "$HOME/bin:$PATH";

}

