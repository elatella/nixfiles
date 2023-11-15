{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./secure-boot.nix
    ./upgrade-diff.nix
  ];

  # Bootloader
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-82eea7f7-ce17-4503-b7e1-52db98518f58".device = "/dev/disk/by-uuid/82eea7f7-ce17-4503-b7e1-52db98518f58";

  # Networking
  networking.networkmanager = {
    enable = true;
    wifi.backend = "iwd";
  };

  # Time zone
  time.timeZone = "Europe/Zurich";

  # AppArmor
  security.apparmor.enable = true;

  # Temporary fix for Swaylock issue
  security.pam.services.swaylock = { };

  # Containers
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    dockerSocket.enable = true;
  };

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };

  # Sound
  sound.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Configure console keymap
  console.keyMap = "sg";

  # Users
  users.users.ela = {
    isNormalUser = true;
    description = "Ela";
    extraGroups = [ "wheel" "networkmanager" ];
    initialPassword = "changeme";
  };
  users.defaultUserShell = pkgs.zsh;

  # Enable Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # System packages
  environment.systemPackages = with pkgs; [
    git
    home-manager
  ];

  programs = {
    # Shell
    zsh.enable = true;

    # Window manager
    hyprland.enable = true;
  };

  services = {
    # Geolocation service
    geoclue2.enable = true;
  };

  system.stateVersion = "23.11";
}
