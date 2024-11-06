{ pkgs, dagger, ... }:

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
      delta = {
        enable = true;
        options = {
          minus-style = "red #37222c";
          minus-emph-style = "red #713137";
          plus-style = "green #20303b";
          plus-emph-style = "green #2c5a66";
          zero-style = "white";
          line-numbers = true;
          line-numbers-minus-style = "white #37222c";
          line-numbers-plus-style = "white #20303b";
          line-numbers-zero-style = "white";
        };
      };
    };
    gitui.enable = true;

    # File manager
    yazi.enable = true;

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
  };

  home.packages = with pkgs; [
    argocd
    brave
    curl
    dagger.packages.${system}.dagger
    delta
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
    nautilus
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
    wireguard-tools
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
  };
}
