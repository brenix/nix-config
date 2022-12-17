{ pkgs, inputs, system, ... }:
{
  home.packages = [ inputs.st.packages."x86_64-linux".st-snazzy ];
}
