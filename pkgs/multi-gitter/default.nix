{ lib
, stdenv
, buildGoModule
, fetchFromGitHub
, installShellFiles
}:

buildGoModule rec {
  pname = "multi-gitter";
  version = "0.43.0";

  src = fetchFromGitHub {
    owner = "lindell";
    repo = "multi-gitter";
    rev = "v${version}";
    sha256 = "sha256-oWvwPrdPgq0ge6tW/p/LUd+F7+f1YcJIjvwv9fIV9Os=";
  };

  vendorSha256 = "sha256-57lp810HxmD2D5TE2EG7AnHv7dOBoWJfBHBApqEzd3I=";

  subPackages = [ "." ];

  ldflags = [ "-s" "-w" ];

  nativeBuildInputs = [ installShellFiles ];

  postInstall = ''
    installShellCompletion --cmd multi-gitter \
      --bash <($out/bin/multi-gitter completion bash) \
      --fish <($out/bin/multi-gitter completion fish) \
      --zsh <($out/bin/multi-gitter completion zsh)
  '';

  meta = with lib; {
    homepage = "https://github.com/lindell/multi-gitter/";
    description = "CLI to update multiple repositories in bulk";
    platforms = with platforms; linux ++ darwin;
    license = licenses.asl20;
    maintainers = with maintainers; [ brenix ];
  };
}
