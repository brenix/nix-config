{ ... }: {

  # Prevent replacing the running kernel image
  security.protectKernelImage = true;

  # Dont prompt for sudo password
  security.sudo.wheelNeedsPassword = false;

}
