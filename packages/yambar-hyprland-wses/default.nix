{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage rec {
  pname = "yambar-hyprland-wses";
  version = "0.2.0-alpha.1";

  src = fetchFromGitHub {
    owner = "jonhoo";
    repo = "yambar-hyprland-wses";
    rev = "v${version}";
    hash = "sha256-FPFo8SYYPmwnfL6XYhbbJGY+A5gphYECMSOLLpPdUjI=";
  };

  cargoHash = "sha256-pnQccbCOVQquEPnNKJ55QiIM5WHmvd7QkpQmImqezok=";

  meta = {
    description = "Enable Yambar to show Hyprland workspaces";
    homepage = "https://github.com/jonhoo/yambar-hyprland-wses";
    license = with lib.licenses; [asl20 mit];
    maintainers = with lib.maintainers; [ludovicopiero];
    mainProgram = "yambar-hyprland-wses";
    platforms = lib.platforms.linux;
  };
}
