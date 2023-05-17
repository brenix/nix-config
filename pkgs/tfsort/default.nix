{ lib, buildGoPackage, fetchFromGitHub }:

buildGoPackage rec {
  pname = "tfsort";
  version = "0.2.3";

  goPackagePath = "github.com/AlexNabokikh/tfsort";

  src = fetchFromGitHub {
    owner = "AlexNabokikh";
    repo = "tfsort";
    rev = "v${version}";
    sha256 = "sha256-dhIzK5fCz60ndHFIqVaU3KQFsz37Ty3Z8+fFbl5Fhtg=";
  };

  meta = with lib; {
    homepage = "https://github.com/AlexNabokikh/tfsort";
    description = "Terraform variables and outputs sorter";
    platforms = with platforms; linux ++ darwin;
    license = licenses.asl20;
    maintainers = with maintainers; [ brenix ];
  };
}
