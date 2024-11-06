{ config, pkgs, dagger, ... }:

let
  theme = import ./theme.nix;
in
{
  programs = {
    # Nix helper
    nh = {
      enable = true;
      flake = "${config.home.homeDirectory}/.nixfiles";
    };

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
          minus-style = "red #${theme.colors.dangerDark}";
          minus-emph-style = "red #${theme.colors.dangerLight}";
          plus-style = "green #${theme.colors.successDark}";
          plus-emph-style = "green #${theme.colors.successLight}";
          zero-style = "white";
          line-numbers = true;
          line-numbers-minus-style = "white #${theme.colors.dangerDark}";
          line-numbers-plus-style = "white #${theme.colors.successDark}";
          line-numbers-zero-style = "white";
        };
      };
    };
    gitui.enable = true;

    # System information
    fastfetch.enable = true;

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

    # AI CLI
    aichat.enable = true;

    # AI coding agent
    opencode = {
      enable = true;
      settings.theme = theme.slug;
    };

    # Go
    go.enable = true;

    # Python
    uv.enable = true;

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
    bluetui
    brave
    curl
    dagger.packages.${system}.dagger
    delta
    dig
    dive
    dust
    fx
    gcc
    gimp3
    gnumake
    golangci-lint
    hugo
    inkscape
    jpegoptim
    killall
    kooha
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
    onefetch
    openshift
    opentofu
    openvpn
    optipng
    podman-compose
    presenterm
    pwgen
    quickemu
    shellcheck
    signal-desktop
    tflint
    thunderbird
    timewarrior
    traceroute
    tree
    rsync
    unzip
    upterm
    usbutils
    whois
    wiremix
    wl-clipboard
    xdg-utils
    yq-go
    zip

    minikube
    docker-machine-kvm2

    simple-scan
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
      spotify = {
        name = "Spotify";
        genericName = "Music Player";
        exec = "brave --app=https://open.spotify.com/";
        categories = [
          "Application"
          "Music"
        ];
        icon = "${config.gtk.iconTheme.package}/share/icons/${theme.icons}/32x32/apps/spotify.svg";
      };
    };
  };
}
