{ inputs }:

final: prev: {

  # Install calicoctl
  calicoctl = prev.callPackage ./calicoctl { };

  # 2022-03-15: Revert to older oh-my-zsh package due to issues with 2022-03-14 update
  oh-my-zsh = prev.oh-my-zsh.overrideAttrs (old: {
    patches = (prev.patches or [ ]) ++ [
      ./oh-my-zsh.patch
    ];
  });

}
