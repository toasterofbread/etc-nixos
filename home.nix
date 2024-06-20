{ config, pkgs, lib, inputs, user, ... }:

{
  imports = [ 
    # ./modules/jdk.nix 
    ./modules/config.nix
  ];

  home.username = user;
  home.homeDirectory = "/home/${user}";
  home.stateVersion = "24.05";
  
  programs.home-manager.enable = true;

  fonts.fontconfig.enable = true;
  i18n.inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [
          fcitx5-mozc
          fcitx5-gtk
      ];
  };

  home.packages = with pkgs; [
      stow # TODO | Remove
      firefox
      kitty
      neofetch
      gnome.nautilus
      gnome.eog
      gnome.file-roller
      gnome.gnome-system-monitor
#      gedit
      waybar
      htop
      pavucontrol
      discord
      betterdiscordctl
      otpclient
      vscode
      swaybg
      mpvpaper
      ffmpeg
      rofi
      socat
      mpv
      slurp
      grim
      wl-clipboard
      docker-compose
      pinta
      sqlitebrowser
      prismlauncher
      qbittorrent
      yt-dlp
      openvpn
      nixpkgs-fmt
      nix-prefetch-git
      jdk21
      gimp

      vsce
        nodejs
        typescript

      android-tools
      sdkmanager
      android-studio

      roboto
      open-sans
      noto-fonts-emoji
      fira-code-symbols
      font-awesome

      xdg-utils
      gnome.gnome-keyring
      lxde.lxsession
      dunst
      libnotify
      #replay-sorcery

      (python3.withPackages (pkgs: with pkgs; [
        notify2 # displaywallpaper
        pyclip # screenshot
        
        # steamgridsync
        beautifulsoup4
        selenium
        pillow
        requests
        hyperlink
      ]))

      (haskellPackages.ghcWithPackages (pkgs: with pkgs; [ 
        cabal-install 
      ]))

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  catppuccin.enable = true;
  catppuccin.flavor = "mocha";
  catppuccin.accent = "mauve";
#  gtk.catppuccin.enable = true;
#  gtk.catppuccin.gnomeShellTheme = true;

  gtk = {
    enable = true;
    catppuccin = {
      gnomeShellTheme = true;
      size = "standard";
      accent = "mauve";
    };
    theme = {
      name = "Catppuccin-Mocha-Standard-Mauve-Dark";
      package = pkgs.catppuccin-gtk.override {
        variant = "mocha";
        size = "standard";
        accents = [ "mauve" ];
        tweaks = [ "normal" ];
      };
    };
  };
  xdg.configFile = {
    "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
    "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
    "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
  };

  home.file = {
    ".config/mpv/input.conf".text = ''
      ALT+j add sub-scale -0.1
      ALT+k add sub-scale +0.1
    '';
  };

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
  #  /etc/profiles/per-user/toaster/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nano";
  };
}
