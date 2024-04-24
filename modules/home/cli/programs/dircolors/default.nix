{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with lib.matrix; let
  cfg = config.cli.programs.dircolors;
in {
  options.cli.programs.dircolors = with types; {
    enable = mkBoolOpt false "Whether or not to enable dircolors";
  };

  config = mkIf cfg.enable {
    programs.dircolors = {
      enable = true;
      enableFishIntegration = true;
      extraConfig = ''
        # -- terms

        COLOR tty

        TERM alacritty
        TERM alacritty-direct
        TERM ansi
        TERM *color*
        TERM con[0-9]*x[0-9]*
        TERM cons25
        TERM console
        TERM cygwin
        TERM dtterm
        TERM dvtm
        TERM dvtm-256color
        TERM Eterm
        TERM eterm-color
        TERM fbterm
        TERM gnome
        TERM gnome-256color
        TERM hurd
        TERM jfbterm
        TERM konsole
        TERM konsole-256color
        TERM kterm
        TERM linux
        TERM linux-c
        TERM mlterm
        TERM putty
        TERM putty-256color
        TERM rxvt*
        TERM rxvt-unicode
        TERM rxvt-256color
        TERM rxvt-unicode256
        TERM screen*
        TERM screen-256color
        TERM st
        TERM st-256color
        TERM terminator
        TERM tmux*
        TERM tmux-256color
        TERM vt100
        TERM xterm*
        TERM xterm-color
        TERM xterm-88color
        TERM xterm-256color

        # -- global defaults

        NORMAL                00
        RESET                 0

        FILE                  00
        DIR                   01;34
        LINK                  36
        MULTIHARDLINK         04;36

        FIFO                  04;01;36
        SOCK                  04;33
        DOOR                  04;01;36
        BLK                   01;33
        CHR                   33

        ORPHAN                31
        MISSING               01;37;41

        EXEC                  01;36

        SETUID                01;04;37
        SETGID                01;04;37
        CAPABILITY            01;37

        STICKY_OTHER_WRITABLE 01;37;44
        OTHER_WRITABLE        01;04;34
        STICKY                04;37;44

        # -- files

        # text/markup

        .csv               37
        .htm               37
        .html              37
        .markdown          37
        .md                37
        .mdown             37
        .rst               37
        .shtml             37
        .txt               37
        .xhtml             37
        .xml               37
        *CONTRIBUTORS      37
        *CONTRIBUTORS.md   37
        *CONTRIBUTORS.txt  37
        *COPYING           37
        *COPYRIGHT         37
        *INSTALL           37
        *INSTALL.md        37
        *INSTALL.md.txt    37
        *LICENSE           37
        *LICENSE-APACHE    37
        *LICENSE-MIT       37
        *README            37
        *README.md         37
        *README.txt        37

        # configs

        *Dockerfile         33
        *passwd             33
        *shadow             33
        .cfg                33
        .conf               33
        .config             33
        .ini                33
        .json               33
        .tml                33
        .toml               33

        # terraform/kubernetes

        .tf                36
        .tfvars            36
        .yaml              35
        .yml               35
        *kustomization.yaml 33

        # encryption

        .3des              01;35
        .aes               01;35
        .gpg               01;35
        .pgp               01;35

        # executables

        .app               01;36
        .bat               01;36
        .btm               01;36
        .cmd               01;36
        .com               01;36
        .exe               01;36
        .reg               01;36

        # git

        .cmake             31
        .cmake.in          31
        .flake8            31
        .gemspec           31
        .gitattributes     31
        .gitconfig         31
        .gitignore         31
        .gitmodules        31
        .make              31
        .travis.yml        31
        *CMakeLists.txt    31
        *MANIFEST.in       31
        *Makefile          31
        *Makefile.am       31
        *configure         31
        *configure.ac      31
        *requirements.txt  31
        *setup.py          31

        # temp files

        .BAK               02;37
        .OLD               02;37
        .ORIG              02;37
        .bak               02;37
        .git               02;37
        .lock              02;37
        .log               02;37
        .old               02;37
        .orig              02;37
        .pid               02;37
        .swo               02;37
        .swp               02;37
        .tmp               02;37
        *package-lock.json 02;37
        *~                 02;37

        # programming languages

        .applescript       36
        .as                36
        .asa               36
        .awk               36
        .bash              36
        .bsh               36
        .c                 36
        .c++               36
        .cabal             36
        .cc                36
        .cgi               36
        .clj               36
        .cp                36
        .cpp               36
        .cr                36
        .cs                36
        .css               36
        .csx               36
        .cxx               36
        .d                 36
        .dart              36
        .def               36
        .di                36
        .diff              36
        .dot               36
        .dpr               36
        .el                36
        .elm               36
        .epp               36
        .erl               36
        .ex                36
        .exs               36
        .fish              36
        .fs                36
        .fsi               36
        .fsx               36
        .go                36
        .gradle            36
        .groovy            36
        .gv                36
        .gvy               36
        .h                 36
        .h++               36
        .hh                36
        .hpp               36
        .hs                36
        .htc               36
        .hxx               36
        .inc               36
        .inl               36
        .ipp               36
        .ipynb             36
        .java              36
        .jl                36
        .js                36
        .kt                36
        .kts               36
        .less              36
        .lisp              36
        .ll                36
        .ltx               36
        .lua               36
        .m                 36
        .matlab            36
        .mir               36
        .ml                36
        .mli               36
        .mn                36
        .nb                36
        .p                 36
        .pas               36
        .patch             36
        .php               36
        .pl                36
        .pm                36
        .pod               36
        .pp                36
        .ps1               36
        .psd1              36
        .psm1              36
        .purs              36
        .py                36
        .r                 36
        .rb                36
        .rs                36
        .sbt               36
        .scala             36
        .sh                36
        .sql               36
        .swift             36
        .t                 36
        .tcl               36
        .td                36
        .tex               36
        .ts                36
        .tsx               36
        .vb                36
        .vim               36
        .zsh               36

        # archives

        .7z                01;32
        .Z                 01;32
        .ace               01;32
        .alz               01;32
        .arc               01;32
        .arj               01;32
        .bz                01;32
        .bz2               01;32
        .cab               01;32
        .cpio              01;32
        .deb               01;32
        .dz                01;32
        .ear               01;32
        .gz                01;32
        .jar               01;32
        .lha               01;32
        .lrz               01;32
        .lz                01;32
        .lz4               01;32
        .lzh               01;32
        .lzma              01;32
        .lzo               01;32
        .rar               01;32
        .rpm               01;32
        .rz                01;32
        .sar               01;32
        .t7z               01;32
        .tar               01;32
        .taz               01;32
        .tbz               01;32
        .tbz2              01;32
        .tgz               01;32
        .tlz               01;32
        .txz               01;32
        .tz                01;32
        .tzo               01;32
        .tzst              01;32
        .war               01;32
        .xz                01;32
        .z                 01;32
        .zip               01;32
        .zoo               01;32
        .zst               01;32

        # audio

        .aac               32
        .au                32
        .flac              32
        .m4a               32
        .mid               32
        .midi              32
        .mka               32
        .mp3               32
        .mpa               32
        .mpeg              32
        .mpg               32
        .ogg               32
        .opus              32
        .ra                32
        .wav               32

        # documents

        .doc               32
        .docx              32
        .dot               32
        .odg               32
        .odp               32
        .ods               32
        .odt               32
        .otg               32
        .otp               32
        .ots               32
        .ott               32
        .pdf               32
        .ppt               32
        .pptx              32
        .xls               32
        .xlsx              32

        # images

        .JPG               32
        .PNG               32
        .bmp               32
        .cgm               32
        .dl                32
        .dvi               32
        .emf               32
        .eps               32
        .gif               32
        .jpeg              32
        .jpg               32
        .mng               32
        .pbm               32
        .pcx               32
        .pgm               32
        .png               32
        .ppm               32
        .pps               32
        .ppsx              32
        .ps                32
        .svg               32
        .svgz              32
        .tga               32
        .tif               32
        .tiff              32
        .xbm               32
        .xcf               32
        .xpm               32
        .xwd               32
        .xwd               32
        .yuv               32

        # video

        .MOV               32
        .anx               32
        .asf               32
        .avi               32
        .axv               32
        .flc               32
        .fli               32
        .flv               32
        .gl                32
        .m2v               32
        .m4v               32
        .mkv               32
        .mov               32
        .mp4               32
        .mpeg              32
        .mpg               32
        .nuv               32
        .ogm               32
        .ogv               32
        .ogx               32
        .qt                32
        .rm                32
        .rmvb              32
        .swf               32
        .vob               32
        .webm              32
        .wmv               32
      '';
    };
  };
}
