{pkgs, ...}: {
  nixpkgs.overlays = [
    # workaround for build failure
    (final: prev: {
      _7zz = prev._7zz.override {useUasm = true;};
    })
  ];
}
