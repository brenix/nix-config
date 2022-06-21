{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "calicoctl";
  version = "3.23.1";

  src = fetchFromGitHub {
    owner = "projectcalico";
    repo = "calico";
    rev = "v${version}";
    sha256 = "sha256-h6dUKRKuiHcgN/ql1MGpQ+N1PTSki2OdIbS0j8DaQqQ=";
  };

  vendorSha256 = "sha256-zjqbH4VIkGXjquKin52+twOxHzRH3RATcwZaQJYwCa0=";

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
