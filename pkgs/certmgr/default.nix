{ lib, buildGoPackage, fetchFromGitHub }:

buildGoPackage rec {
  version = "3.0.3";
  pname = "certmgr";

  goPackagePath = "github.com/cloudflare/certmgr/";

  src = fetchFromGitHub {
    owner = "cloudflare";
    repo = "certmgr";
    rev = "v${version}";
    hash = "sha256-MgNPU06bv31tdfUnigcmct8UTVztNLXcmTg3H/J7mic=";
  };

  meta = with lib; {
    homepage = "https://cfssl.org/";
    description = "Cloudflare's certificate manager";
    platforms = platforms.linux;
    license = licenses.bsd2;
    maintainers = with maintainers; [ johanot srhb ];
  };
}
