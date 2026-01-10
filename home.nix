{ config, pkgs, hy3, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "kartoma";
  home.homeDirectory = "/home/kartoma";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/kartoma/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
  };

  programs.fish = {
     enable = true;
     shellAliases = {
        c = "clear && krabby random -i";
        ll = "ls -al";
	nrs = "cd ~/dotfiles && sudo nixos-rebuild switch --flake --impure";
	hms = "cd ~/dotfiles && home-manager switch --flake .";
        nrsu = "cd ~/dotfiles && nix flake update && sudo nixos-rebuild switch --flake --impure && home-manager switch --flake .";
       };
     interactiveShellInit = ''
      set -U fish_greeting
      if status is-interactive
       krabby random -i
      end
     ''; 
 };

  programs.kitty = {
    enable = true;
    themeFile = "rose-pine-moon";
    font = {
       name = "JetBrainsMono Nerd Font";
       size = 13;
       };
    };
  
 services.mako = {
  enable = true;
 };

home.pointerCursor = {
  gtk.enable = true;
  x11.enable = true;
  name = "Kirby";
  size = 24;
  package = pkgs.runCommand "kirby-cursor" {
    src = ./other/cursor/Kirby;
  } ''
    mkdir -p $out/share/icons/Kirby
    cp -rT "$src" "$out/share/icons/Kirby"
  '';
};


# Hyprland
wayland.windowManager.hyprland = {
  enable = true;
    systemd = {
    enable = true;
    variables = [ "--all" ];
  };
  xwayland.enable = true;
 
  plugins = [
    hy3.packages.${pkgs.stdenv.hostPlatform.system}.hy3
  ];

  settings = {
    "$mod" = "Alt";

    general = {
      gaps_in = 3;
      gaps_out = 10;
      layout = "hy3";  # use hy3 layout
    };

    plugin.hy3 = {
      autotile.enable = true;
    };

    bind = [
      # hy3 focus movement
      "$mod, h, hy3:movefocus, l"
      "$mod, j, hy3:movefocus, d"
      "$mod, k, hy3:movefocus, u"
      "$mod, l, hy3:movefocus, r"

      # hy3 move window
      "$mod SHIFT, h, hy3:movewindow, l"
      "$mod SHIFT, j, hy3:movewindow, d"
      "$mod SHIFT, k, hy3:movewindow, u"
      "$mod SHIFT, l, hy3:movewindow, r"

      # your existing commands
      "$mod, Q, exec, kitty"
      "$mod SHIFT, Q, killactive"
      "$mod, R, exec, wofi --show drun"
      "$mod SHIFT, S,exec, hyprshot -m region"
      "$mod, V, togglefloating"
      "$mod, F, fullscreen"
      "$mod, 1, workspace, 1"
      "$mod, 2, workspace, 2"
      "$mod, 3, workspace, 3"
      "$mod, 4, workspace, 4"
      "$mod, 5, workspace, 5"
      "$mod, 6, workspace, 6"
      "$mod, 7, workspace, 7"
      "$mod, 8, workspace, 8"
      "$mod, 9, workspace, 9"
      "$mod SHIFT, 1, movetoworkspace, 1"
      "$mod SHIFT, 2, movetoworkspace, 2"
      "$mod SHIFT, 3, movetoworkspace, 3"
      "$mod SHIFT, 4, movetoworkspace, 4"
      "$mod SHIFT, 5, movetoworkspace, 5"
      "$mod SHIFT, 6, movetoworkspace, 6"
      "$mod SHIFT, 7, movetoworkspace, 7"
      "$mod SHIFT, 8, movetoworkspace, 8"
      "$mod SHIFT, 9, movetoworkspace, 9"
    ];

    monitor = [
      "HDMI-A-2, 2560x1440@360, 0x0, 1"
      "DP-2, 2560x1440@240, 2560x0, 1"
    ];

    decoration = {
      rounding = 10;
      rounding_power = 2;
      active_opacity = 1.0;
      inactive_opacity = 1;

      shadow = {
        enabled = true;
        range = 4;
        render_power = 3;
        color = "rgba(40E0D0ee)";
      };

      blur = {
        enabled = false;
        size = 3;
        passes = 1;
        vibrancy = 0.1696;
      };
    };

    misc = { };

    env = [
    ];

    exec-once = [ 
      "hyprctl setcursor Kirby 24"
    ];

    windowrulev2 = [
      "tile,class:^(.*)$"
    ];

    animations = {
      enabled = true;
      bezier = [
        "easeOutQuint, 0.23, 1, 0.32, 1"
        "easeInOutCubic, 0.65, 0.05, 0.36, 1"
        "linear, 0, 0, 1, 1"
        "almostLinear, 0.5, 0.5, 0.75, 1"
        "quick, 0.15, 0, 0.1, 1"
      ];
      animation = [
        "global, 1, 10, default"
        "border, 1, 5.39, easeOutQuint"
        "windows, 1, 4.79, easeOutQuint"
        "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
        "windowsOut, 1, 1.49, linear, popin 87%"
        "fadeIn, 1, 1.73, almostLinear"
        "fadeOut, 1, 1.46, almostLinear"
        "fade, 1, 3.03, quick"
        "layers, 1, 3.81, easeOutQuint"
        "layersIn, 1, 4, easeOutQuint, fade"
        "layersOut, 1, 1.5, linear, fade"
        "fadeLayersIn, 1, 1.79, almostLinear"
        "fadeLayersOut, 1, 1.39, almostLinear"
        "workspaces, 1, 1.94, almostLinear, fade"
        "workspacesIn, 1, 1.21, almostLinear, fade"
        "workspacesOut, 1, 1.94, almostLinear, fade"
        "zoomFactor, 1, 7, quick"
      ];
    };
  };

};

# Hyprpaper
services.hyprpaper = {
   enable = true;
   };


 programs.home-manager.enable = true;
}
