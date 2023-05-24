{ vimUtils, fetchFromGitHub }:
vimUtils.buildVimPlugin {
  pname = "comment-box-nvim";
  version = "2022-02-05";
  dontBuild = true;
  src = fetchFromGitHub {
    owner = "LudoPinelli";
    repo = "comment-box.nvim";
    rev = "6672213bd5d2625a666a297b66307967effa50bc";
    sha256 = "sha256-hD9eCcrDsispi+Nvwjy/MlNW0UmFfSbh8arQpCjeneM=";
  };
  meta.homepage = "https://github.org/LudoPinelli/comment-box.nvim";
}
