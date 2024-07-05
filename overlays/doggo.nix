{
  nixpkgs.overlays = [
    (final: prev: {
      doggo = prev.doggo.overrideAttrs (oldAttrs: {
        version = "1.0.3";
        src = prev.fetchFromGitHub {
          owner = "mr-karan";
          repo = "doggo";
          rev = "v1.0.3";
          hash = "sha256-lsSfrWGFn9gUGYHB3zFWCQFDL0YWeJxxLf38vKw/oNs=";
        };
        vendorHash = prev.lib.fakeHash;
        ldflags = [
          "-w -s"
          "-X main.buildVersion=v1.0.3"
        ];
      });
    })
  ];
}
