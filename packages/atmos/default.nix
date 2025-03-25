{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "atmos";
  version = "1.167.0";

  src = fetchFromGitHub {
    owner = "cloudposse";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-CcRMnn4PRC70sp0viEG79ZErGR46GMPs6R9Xgj4Quak=";
  };

  vendorHash = "sha256-7STPMi1Oo1FLmCc22PUcnBL7CauLS9Wywk8gtSaEShc=";

  ldflags = [
    "-s"
    "-w"
    "-X github.com/cloudposse/atmos/cmd.Version=v${version}"
  ];

  doCheck = false;
  doInstallCheck = false;

  meta = with lib; {
    homepage = "https://atmos.tools";
    changelog = "https://github.com/cloudposse/atmos/releases/tag/v${version}";
    description = "Universal Tool for DevOps and Cloud Automation (works with terraform, helm, helmfile, etc)";
    mainProgram = "atmos";
    license = licenses.asl20;
  };
}
