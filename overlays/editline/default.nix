# TODO: Remove once fixed upstream
# Fixes a regression after some patches were added upstream
{...}: _final: prev: {
  editline = prev.editline.overrideAttrs (_oldAttrs: {
    patches = [
      (prev.fetchpatch {
        name = "fix-for-home-end-in-tmux.patch";
        url = "https://github.com/troglobit/editline/commit/265c1fb6a0b99bedb157dc7c320f2c9629136518.patch";
        sha256 = "sha256-9fhQH0hT8BcykGzOUoT18HBtWjjoXnePSGDJQp8GH30=";
      })

      (prev.fetchpatch {
        name = "autoconf-2.72.patch";
        url = "https://github.com/troglobit/editline/commit/f444a316f5178b8e20fe31e7b2d979e651da077e.patch";
        hash = "sha256-m3jExTkPvE+ZBwHzf/A+ugzzfbLmeWYn726l7Po7f10=";
      })
    ];
  });
}
