{ config, ... }:

{
  imports = [
    ./window-manager.nix
    ./status-bar.nix
    ./terminal.nix
    ./shell.nix
    ./editor.nix
    ./tools.nix
  ];

  home.username = "ela";
  home.homeDirectory = "/home/${config.home.username}";

  home.stateVersion = "25.11";

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;
}
