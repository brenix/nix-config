{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "helmfile";
  version = "0.148.1";

  src = fetchFromGitHub {
    owner = "helmfile";
    repo = "helmfile";
    rev = "v${version}";
    sha256 = "sha256-Nvf26ahWc1fCWngroc+5gPV1T5UBa/6ix/I9tdQ01t8=";
  };

  vendorSha256 = "sha256-hwJ3vVbGE7L+mkjDzxy6xDT9hjA5cIwxQsHaJpozwvE=";

  doCheck = false;

  subPackages = [ "." ];

  ldflags = [ "-s" "-w" "-X github.com/helmfile/helmfile/pkg/app/version.Version=${version}" ];

  meta = {
    description = "Deploy Kubernetes Helm charts";
    homepage = "https://github.com/helmfile/helmfile";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ brenix ];
    platforms = lib.platforms.unix;
  };
}
