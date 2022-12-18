{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "helmfile";
  version = "0.149.0";

  src = fetchFromGitHub {
    owner = "helmfile";
    repo = "helmfile";
    rev = "v${version}";
    sha256 = "sha256-d3wb1m65TaWrRE23LDytnkBuAcHazfzwTKwINhC9hW0=";
  };

  vendorSha256 = "sha256-akxA1AeYuaIKBAgt+u5fWcFYYP1YVMT79l5WwTn1bnI=";

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
