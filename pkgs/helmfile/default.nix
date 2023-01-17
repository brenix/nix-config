{ lib, buildGoModule, fetchFromGitHub, installShellFiles }:

buildGoModule rec {
  pname = "helmfile";
  version = "0.150.0";

  src = fetchFromGitHub {
    owner = "helmfile";
    repo = "helmfile";
    rev = "v${version}";
    sha256 = "sha256-7wCt+JAuozsd+LifLArfPNwiKK/tDvgwpIwVCW4nU3Y=";
  };

  vendorSha256 = "sha256-vLLS+/Xfnlt6cvkNvXKX3DVLku1Q4bRCiv2vMTfOnfw=";

  doCheck = false;

  subPackages = [ "." ];

  ldflags = [ "-s" "-w" "-X github.com/helmfile/helmfile/pkg/app/version.Version=${version}" ];

  nativeBuildInputs = [ installShellFiles ];

  postInstall = ''
    mkdir completions
    $out/bin/helmfile completion bash > completions/helmfile || true
    $out/bin/helmfile completion zsh > completions/_helmfile || true
    $out/bin/helmfile completion fish > completions/helmfile.fish || true
    installShellCompletion --cmd helmfile \
      --bash completions/helmfile  \
      --zsh completions/_helmfile \
      --fish completions/helmfile.fish
  '';

  meta = {
    description = "Deploy Kubernetes Helm charts";
    homepage = "https://github.com/helmfile/helmfile";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ brenix ];
    platforms = lib.platforms.unix;
  };
}
