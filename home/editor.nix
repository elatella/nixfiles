{ pkgs, ... }:

{
  programs.vscodium.enable = true;

  home.sessionVariables = {
    EDITOR = "${pkgs.neovim}/bin/nvim";
    VISUAL = "${pkgs.vscodium}/bin/codium";
  };
}
