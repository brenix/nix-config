{
  home.file.".mrconfig".text = ''
    [DEFAULT]
    jobs = 5
    git_update = git pull --prune --tags "$@"
    git_fetch = git fetch --prune --prune-tags
    git_gc = git gc --aggressive "$@"
    git_tags = git tag -l
    git_branches = git branch
    branch = printf "\e[1;33m%-6s\e[m\n" $(git rev-parse --abbrev-ref HEAD)
    default = git checkout $(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')
    reset = git reset --hard HEAD && git checkout $(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@') && git clean -d -f
  '';
}
