{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "calicoctl";
  version = "3.22.1";

  src = fetchFromGitHub {
    owner = "projectcalico";
    repo = "calico";
    rev = "v${version}";
    sha256 = "sha256-Ed+ddWlk30SWysGUx0JiJDNlwLe7GUPxoBVcezpALDs=";
  };

  vendorSha256 = "sha256-hsn7RCcqm8imLT+PhyPPkN/bi1h//h1OnENAgyHalAs=";

  doCheck = false;

  subPackages = [ "calicoctl/calicoctl" ];

  ldflags = [
    "-s"
    "-w"
    "-X github.com/projectcalico/calico/calicoctl/calicoctl/commands.VERSION=${version}"
    "-X github.com/projectcalico/calico/calicoctl/calicoctl/commands/common.VERSION=${version}"
  ];

  meta = {
    description = "Calico CLI tool to manage network and security policy";
    homepage = "https://github.com/projectcalico/calico";
    license = lib.licenses.asl20;
    /* maintainers = with lib.maintainers; [ brenix ]; */
    platforms = lib.platforms.unix;
  };
}
