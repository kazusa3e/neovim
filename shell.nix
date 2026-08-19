let
  pkgs = import <nixpkgs> { };
in
pkgs.mkShell {
  name = "neovim-shell";

  packages = with pkgs; [
    nil
    nixfmt
    lua-language-server
    stylua
  ];
}
