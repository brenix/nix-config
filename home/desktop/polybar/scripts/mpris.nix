{ pkgs, ... }:

let pctl = "${pkgs.playerctl}/bin/playerctl";
in
pkgs.writeShellScriptBin "mpris" ''
  playing=$(${pctl} -s --player=spotify,%any metadata --format '{{ artist }} - {{ title }}')

  if [[ $? -eq 0 ]]; then
    status=$(${pctl} -s status)
    case $status in
      "Paused") playpause="-" ;;
      "Playing") playpause="+" ;;
    esac

    echo -e "%{A:${pctl} play-pause & disown:}$playing%{A} %{A:${pctl} previous & disown:}<%{A} %{A:${pctl} next & disown:}>%{A}"
  else
    echo ""
  fi
''
