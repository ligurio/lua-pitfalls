{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "lua-pitfalls";

  buildInputs = with pkgs; [
    jekyll
    lua5_1
    lua5_2
    lua5_3
    lua5_4
    luajit_2_0
    luajit_2_1
    luajit_openresty
  ];
}
