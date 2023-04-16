{ config, ... }:

let
  inherit (config.colorscheme) colors;
in
{
  xresources.properties."*.font" = "-*-terminus-medium-*-*-*-14-*-*-*-*-*-*-*";
  xresources.properties."*.boldFont" = "-*-terminus-medium-*-*-*-14-*-*-*-*-*-*-*";
  xresources.properties."*.lineSpace" = 0;
  xresources.properties."*.letterSpace" = 0;
  xresources.properties."*.background" = "#${colors.base00}";
  xresources.properties."*.base00" = "#${colors.base00}";
  xresources.properties."*.base01" = "#${colors.base01}";
  xresources.properties."*.base02" = "#${colors.base02}";
  xresources.properties."*.base03" = "#${colors.base03}";
  xresources.properties."*.base04" = "#${colors.base04}";
  xresources.properties."*.base05" = "#${colors.base05}";
  xresources.properties."*.base06" = "#${colors.base06}";
  xresources.properties."*.base07" = "#${colors.base07}";
  xresources.properties."*.base08" = "#${colors.base08}";
  xresources.properties."*.base09" = "#${colors.base09}";
  xresources.properties."*.base0A" = "#${colors.base0A}";
  xresources.properties."*.base0B" = "#${colors.base0B}";
  xresources.properties."*.base0C" = "#${colors.base0C}";
  xresources.properties."*.base0D" = "#${colors.base0D}";
  xresources.properties."*.base0E" = "#${colors.base0E}";
  xresources.properties."*.base0F" = "#${colors.base0F}";
  xresources.properties."*.color0" = "#${colors.base00}";
  xresources.properties."*.color1" = "#${colors.base08}";
  xresources.properties."*.color2" = "#${colors.base0B}";
  xresources.properties."*.color3" = "#${colors.base0A}";
  xresources.properties."*.color4" = "#${colors.base0D}";
  xresources.properties."*.color5" = "#${colors.base0E}";
  xresources.properties."*.color6" = "#${colors.base0C}";
  xresources.properties."*.color7" = "#${colors.base05}";
  xresources.properties."*.color8" = "#${colors.base03}";
  xresources.properties."*.color9" = "#${colors.base08}";
  xresources.properties."*.color10" = "#${colors.base0B}";
  xresources.properties."*.color11" = "#${colors.base0A}";
  xresources.properties."*.color12" = "#${colors.base0D}";
  xresources.properties."*.color13" = "#${colors.base0E}";
  xresources.properties."*.color14" = "#${colors.base0C}";
  xresources.properties."*.color15" = "#${colors.base07}";
  xresources.properties."*.color16" = "#${colors.base09}";
  xresources.properties."*.color17" = "#${colors.base0F}";
  xresources.properties."*.color18" = "#${colors.base01}";
  xresources.properties."*.color19" = "#${colors.base02}";
  xresources.properties."*.color20" = "#${colors.base04}";
  xresources.properties."*.color21" = "#${colors.base06}";
  xresources.properties."*.cursorColor" = "#${colors.base05}";
  xresources.properties."*.foreground" = "#${colors.base05}";
  xresources.properties."Xft.antialias" = 1;
  xresources.properties."Xft.autohint" = 0;
  xresources.properties."Xft.dpi" = config.dpi;
  xresources.properties."Xft.hinting" = 1;
  xresources.properties."Xft.hintstyle" = "hintslight";
  xresources.properties."Xft.lcdfilter" = "lcddefault";
  xresources.properties."Xft.rgba" = "rgb";
}
