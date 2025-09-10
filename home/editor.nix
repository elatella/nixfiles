{ pkgs, ... }:

let
  theme = import ./theme.nix;
in
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
  };

  home.sessionVariables = {
    EDITOR = "${pkgs.neovim}/bin/nvim";
    VISUAL = "${pkgs.vscodium}/bin/codium";
  };
}
