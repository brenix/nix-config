{ config, ... }:
let
  inherit (config.colorscheme) colors kind;
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
        minus-style = if kind == "dark" then "black #9f7777" else null;
        minus-emph-style = if kind == "dark" then "black #f7b9b9" else null;
        plus-style = if kind == "dark" then "black #98ad9c" else null;
        plus-emph-style = if kind == "dark" then "black #e1ffe6" else null;
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
      log = { date = "short"; };
      protocol = { version = 2; };
      pull = { rebase = true; };
      push = { default = "simple"; };
    };
  };
}
