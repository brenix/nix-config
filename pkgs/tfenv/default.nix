{ pkgs, stdenvNoCC, lib, fetchurl, makeWrapper }:

let
  version = "3.0.0";
in
stdenvNoCC.mkDerivation rec {
  pname = "tfenv";
  inherit version;

  src = fetchurl {
    url = "https://github.com/tfutils/tfenv/archive/refs/tags/v${version}.tar.gz";
    sha256 = "sha256-RjEy5FohH6P6+F5i/fqpu3RjQ/8ZVMy62RyudD3ztkg=";
  };

  dontConfigure = true;
  dontBuild = true;

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';

  # TFENV_CONFIG_DIR is only set if not already specified.
  # Using '--run export ...' instead of the builtin --set-default, since
  # expanding $HOME fails with --set-default.
  fixupPhase = ''
    wrapProgram $out/bin/tfenv \
    --prefix PATH : "${lib.makeBinPath [ pkgs.unzip ]}" \
    --run 'export TFENV_CONFIG_DIR="''${TFENV_CONFIG_DIR:-$HOME/.local/tfenv}"' \
    --run 'mkdir -p $TFENV_CONFIG_DIR'
    wrapProgram $out/bin/terraform \
    --run 'export TFENV_CONFIG_DIR="''${TFENV_CONFIG_DIR:-$HOME/.local/tfenv}"' \
    --run 'mkdir -p $TFENV_CONFIG_DIR'
  '';

  meta = with lib; {
    description = "Terraform version manager";
    homepage = "https://github.com/tfutils/tfenv";
    license = licenses.mit;
    platforms = platforms.unix;
  };
}
