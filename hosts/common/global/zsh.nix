{
  environment.pathsToLink = [ "/share/zsh" ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableBashCompletion = true;
    autosuggestions.enable = true;
  };
}
