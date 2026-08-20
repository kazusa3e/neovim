let
  pkgs = import <nixpkgs> { };
in
pkgs.mkShell {
  name = "neovim-shell";

  packages = with pkgs; [
    lua-language-server
    stylua
  ];
}
