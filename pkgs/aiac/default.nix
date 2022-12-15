{ stdenv, lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "aiac";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "gofireflyio";
    repo = "aiac";
    rev = "v${version}";
    sha256 = "sha256-ZZXOPy3UKYLL7cE1YTYImJBk0CemWklwE8L0ixhzvcA=";
  };

  vendorHash = "sha256-6Pin/YWzj2ZbuvtFgxnoVQIg+zoz/CZZ/WDOIp9QTuc=";

  meta = with lib; {
    homepage = "https://github.com/gofireflyio/aiac";
    description = "Artificial Intelligence Infrastructure-as-Code Generator.";
    platforms = with platforms; linux ++ darwin;
    license = licenses.asl20;
    maintainers = with maintainers; [ brenix ];
  };
}
