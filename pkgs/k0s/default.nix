{ lib
, stdenv
, fetchurl
, installShellFiles
}:
stdenv.mkDerivation rec {
  pname = "k0s";
  version = "1.28.4+k0s.0";
  src = fetchurl {
    url = "https://github.com/k0sproject/k0s/releases/download/v1.28.4+k0s.0/k0s-v1.28.4+k0s.0-amd64";
    hash = "sha256-kmvLaEePDrW7hHm/AdOVJBAjRtnyS59Tau3fcf3VqXU=";
  };

  nativeBuildInputs = [ installShellFiles ];

  phases = [ "installPhase" ];

  installPhase =
    ''
      install -m 755 -D -- "$src" "$out"/bin/k0s
      installShellCompletion --cmd k0s \
        --bash <($out/bin/k0s completion bash) \
        --fish <($out/bin/k0s completion fish) \
        --zsh <($out/bin/k0s completion zsh)
    '';

  meta = with lib; {
    description = "k0s - The Zero Friction Kubernetes";
    homepage = "https://k0sproject.io";
    license = licenses.asl20;
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
    mainProgram = pname;
    maintainers = with maintainers; [ twz123 ];
  };
}
