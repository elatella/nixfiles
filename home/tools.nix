{ pkgs, ... }:

{
  programs = {
    # Git
    git = {
      enable = true;
      userName = "Raphaela Seeger";
      userEmail = "elatella@users.noreply.github.com";
      signing = {
        key = null;
        signByDefault = true;
      };
      diff-so-fancy.enable = true;
    };
    gitui.enable = true;

    # File manager
    yazi = {
      enable = true;
      enableZshIntegration = true;
    };

    # Encryption
    gpg.enable = true;

    # Fuzzy finder
    fzf.enable = true;

    # Faster find
    fd.enable = true;

    # Fast grepping
    ripgrep.enable = true;

    # Process viewer
    bottom.enable = true;

    # Quick navigation
    zoxide.enable = true;

    # JSON parser
    jq.enable = true;

    # PDF viewer
    zathura.enable = true;

    # Task management
    taskwarrior = {
      enable = true;
      package = pkgs.taskwarrior3;
    };

    # Media player
    mpv.enable = true;

    # GitHub CLI
    gh.enable = true;

    # Image viewer
    imv.enable = true;

    # Go
    go.enable = true;

    # Simplified manuals
    tealdeer = {
      enable = true;
      settings = {
        updates.auto_update = true;
      };
    };

    # AWS CLI
    awscli.enable = true;

    # Python dependency management
    poetry.enable = true;
  };

  home.packages = with pkgs; [
    argocd
    brave
    curl
    diff-so-fancy
    dig
    dive
    dust
    fx
    gcc
    gimp
    gnumake
    golangci-lint
    hugo
    inkscape
    jpegoptim
    kubectl
    kubectx
    kubernetes-helm
    kubeseal
    kustomize
    krita
    libreoffice
    libwebp
    lolcat
    nodejs
    nodePackages.svgo
    openshift
    opentofu
    openvpn
    optipng
    podman-compose
    pulsemixer
    pwgen
    quickemu
    shellcheck
    signal-desktop
    termshark
    tflint
    thunderbird
    timewarrior
    tree
    rsync
    unzip
    upterm
    wf-recorder
    wget2
    whois
    wl-clipboard
    xdg-utils
    yq
    zip
  ];

  xdg = {
    dataFile = {
      "task/hooks/on-modify.timewarrior" = {
        source = "${pkgs.timewarrior}/share/doc/timew/ext/on-modify.timewarrior";
        executable = true;
      };
    };
    mimeApps = {
      enable = true;
      defaultApplications = {
        "application/pdf" = [ "org.pwmt.zathura.desktop" ];
        "image/png" = [ "imv.desktop" ];
        "image/jpeg" = [ "imv.desktop" ];
        "image/svg" = [ "imv.desktop" ];
      };
    };
    desktopEntries = {
      bottom = {
        name = "Bottom";
        genericName = "System Monitor";
        terminal = true;
        exec = "${pkgs.bottom}/bin/btm";
      };
      taskwarrior = {
        name = "Taskwarrior";
        genericName = "Task Manager";
        terminal = true;
        exec = "${pkgs.taskwarrior-tui}/bin/taskwarrior-tui";
      };
      chatgpt = {
        name = "ChatGPT";
        genericName = "Chat Bot";
        exec = "${pkgs.brave}/bin/brave --app=https://chat.openai.com/";
      };
      spotify = {
        name = "Spotify";
        genericName = "Music Player";
        exec = "${pkgs.brave}/bin/brave --app=https://open.spotify.com";
      };
    };
  };
}
