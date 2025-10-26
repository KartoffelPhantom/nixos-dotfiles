 { config, pkgs, ... }:

 {
   home.username = "kartoma";
   home.homeDirectory = "/home/kartoma";
   home.stateVersion = "25.05";

   programs.bash = {
     enable = true;
     shellAliases = {
       btw = "I wanna end it all";
     };
    };
  }
