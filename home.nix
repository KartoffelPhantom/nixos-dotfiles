{ config, pkgs, ... }:

{
  home.username = "kartoma";
  home.homeDirectory = "/home/kartoma";
  home.stateVersion = "25.05";

  programs.bash = {
    enable = true;
    shellAliases = {
      btw = "echo I wanna end it all";
      nrs = "cd /home/kartoma/dotfiles && sudo nixos-rebuild switch --impure --flake .#kys";
      nrsu = "cd /home/kartoma/dotfiles && nix flake update && sudo nixos-rebuild switch --impure --flake .#kys";

      c = "clear && fastfetch";
    };

    initExtra = ''
      PS1='\[\e[38;5;221;2m\]\u\[\e[0m\] in \[\e[38;5;222m\]\w\[\e[0m\] \\$ '

      fastfetch
    '';
  };
  
  #Configs 
  home.file.".config/i3/config".source = /home/kartoma/dotfiles/i3/config;
  home.file.".config/kitty/kitty.conf".source = /home/kartoma/dotfiles/kitty/kitty.conf;
  home.file.".config/kitty/current-theme.conf".source = /home/kartoma/dotfiles/kitty/current-theme.conf;
  home.file.".config/btop/btop.conf".source = /home/kartoma/dotfiles/btop/btop.conf;

  
  home.packages = with pkgs; [
    bat
    fastfetch
  ];
}

