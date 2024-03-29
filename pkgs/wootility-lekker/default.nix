{ appimageTools
, fetchurl
, lib
, xorg
, udev
, wooting-udev-rules
}:
let
  pname = "wootility-lekker";
  version = "4.6.12";
in
appimageTools.wrapType2 rec {
  name = "${pname}-${version}";

  src = fetchurl {
    url = "https://s3.eu-west-2.amazonaws.com/wooting-update/wootility-lekker-linux-latest/wootility-lekker-${version}.AppImage";
    sha256 = "sha256-Dbg8XjBBmafwt4DoG7E9UAq7jChy/7L3aTed4Sfr6mQ=";
  };

  profile = ''
    export LC_ALL=C.UTF-8
  '';

  multiPkgs = extraPkgs;
  extraPkgs =
    pkgs: (appimageTools.defaultFhsEnvArgs.multiPkgs pkgs) ++ [
      udev
      wooting-udev-rules
      xorg.libxkbfile
    ];
  extraInstallCommands = "mv $out/bin/{${name},${pname}}";

  meta = with lib; {
    homepage = "https://wooting.io/wootility";
    description = "A customization and management software for Wooting keyboards";
    platforms = [ "x86_64-linux" ];
    license = "unknown";
    maintainers = with maintainers; [ brenix ];
  };
}
