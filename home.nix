{ config, pkgs, ... }:

{
  home.username = "kartoma";
  home.homeDirectory = "/home/kartoma";
  home.stateVersion = "25.05";

  programs.bash = {
    enable = true;
    shellAliases = {
      btw = "echo I wanna end it all";
      nrs = "sudo nixos-rebuild switch --impure";
      nrsu = "cd /home/kartoma/dotfiles && nix flake update && sudo nixos-rebuild switch --impure --flake .#kys && ./git.sh && cd";

      c = "clear && fastfetch";
    };

    initExtra = ''
      PS1='\[\e[38;5;221m\]\u\[\e[0m\] in \[\e[38;5;222m\]\w\[\e[0m\] \\$ '
      
      fastfetch
    '';
  };

  home.packages = with pkgs; [
    bat
    fastfetch
  ];
}

