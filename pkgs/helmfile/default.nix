{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "helmfile";
  version = "0.147.0";

  src = fetchFromGitHub {
    owner = "helmfile";
    repo = "helmfile";
    rev = "v${version}";
    sha256 = "sha256-W6xkLqH0wHvCmwzwQyXpRbcj/itm3leRMFGa5RIYJ4A=";
  };

  vendorSha256 = "sha256-77dedk8QG3KNQX21IbA9HuJPRgNwgwqhmZvViRnxJHw=";

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
