{ config, pkgs, ... }:
let
  inherit (config.colorscheme) kind;
in
{
  programs.git = {
    enable = true;

    userName = "Paul Nicholson";
    userEmail = "brenix@gmail.com";

    aliases = {
      branch-name = "!git rev-parse --abbrev-ref HEAD";
      publish = "!git push -u origin $(git branch-name)";
      unpublish = "!git push origin :$(git branch-name)";
      da =
        "!git checkout main && git branch --no-color | grep -v 'main' | xargs -n 1 git branch -d";
    };

    delta = {
      enable = true;
      options = {
        color-only = true;
        light = if kind == "light" then true else false;
        minus-style = if kind == "dark" then "black #9f7777" else "white #ffebe9";
        minus-emph-style = if kind == "dark" then "black #f7b9b9" else "white #ffc0c0";
        plus-style = if kind == "dark" then "black #98ad9c" else "white #e6ffec";
        plus-emph-style = if kind == "dark" then "black #e1ffe6" else "white #abf2bc";
        syntax-theme = "none";
      };
    };

    ignores = [
      # compiled source files
      "*.com"
      "*.class"
      "*.dll"
      "*.exe"
      "*.o"
      "*.so"
      # compressed files
      "*.7zip"
      "*.dmg"
      "*.gz"
      "*.iso"
      "*.jar"
      "*.rar"
      "*.tar"
      "*.xz"
      "*.zip"
      # logs
      "*.log"
      "*.sql"
      "*.sqlite"
      # os generated files
      ".DS_Store"
      ".DS_Store?"
      "._*"
      ".Spotlight-V100"
      ".Trashes"
      "ehthumbs.db"
      "Thumbs.db"
    ];

    includes = [{
      path = "~/work/.gitconfig";
      condition = "gitdir:~/work/";
    }];

    extraConfig = {
      apply = { whitespace = "strip"; };
      branch = { autosetuprebase = "always"; };
      color."branch" = {
        current = "normal reverse";
        local = "normal";
        remote = "green";
      };
      color."diff" = {
        meta = "white bold";
        frag = "magenta bold";
        old = "red bold";
        new = "green bold";
      };
      color."status" = {
        added = "green";
        changed = "magenta";
        untracked = "white";
      };
      core = {
        compression = 0;
        preloadindex = true;
        whitespace = "fix,-indent-with-non-tab,trailing-space,cr-at-eol";
      };
      diff."sopsdiffer" = { textconv = "sops -d"; };
      format = {
        pretty = "%C(yellow)%H%Creset %C(magenta)%cd%Creset %d %s %C(green)%an";
      };
      http = { postBuffer = 524288000; };
      init = { defaultBranch = "main"; };
      feature = { manyFiles = "true"; };
      log = { date = "short"; };
      protocol = { version = 2; };
      pull = { rebase = true; };
      push = { default = "simple"; };
      fetch = { pruneTags = true; prune = true; };
    };
  };

  home.packages = with pkgs; [
    mr
  ];

  home.file.".mrconfig".text = ''
    [DEFAULT]
    jobs = 5
    git_update = git pull --prune --tags --force "$@"
    git_fetch = git fetch --prune --prune-tags
    git_gc = git gc --aggressive "$@"
    git_tags = git tag -l
    git_branches = git branch
    branch = printf "\e[1;33m%-6s\e[m\n" $(git rev-parse --abbrev-ref HEAD)
    default = git checkout $(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')
    reset = git reset --hard HEAD && git checkout $(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@') && git clean -d -f
  '';

  home.persistence = {
    "/persist/home/brenix" = {
      files = [
        ".gitconfig" # local work configuration (not managed by home-manager)
      ];
      allowOther = true;
    };
  };
}
