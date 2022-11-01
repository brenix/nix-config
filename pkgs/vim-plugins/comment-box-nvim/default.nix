{ vimUtils, fetchFromGitHub }:
vimUtils.buildVimPlugin {
  pname = "comment-box-nvim";
  version = "2022-02-05";
  dontBuild = true;
  src = fetchFromGitHub {
    owner = "LudoPinelli";
    repo = "comment-box.nvim";
    rev = "117d55108edf3758da52cf1117584b974f5e76da";
    sha256 = "sha256-E+wQUtLJwqN42XYLu2OzAEKMMUyRKjcZHwgOOEG0XDM=";
  };
  meta.homepage = "https://github.org/LudoPinelli/comment-box.nvim";
}
