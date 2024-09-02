{
  programs.nixvim = {
    filetype = {
      extension = {
        "ignore" = "gitignore";
      };

      pattern = {
        ".*/hypr/.*%.conf" = "hyprlang";
        "flake.lock" = "json";
      };
    };
  };
}
