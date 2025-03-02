final: prev: {
  cloudflared = prev.cloudflared.overrideAttrs (old: {
    version = "2025.2.1";
    src = prev.fetchFromGitHub {
      owner = "cloudflare";
      repo = "cloudflared";
      rev = final.cloudflared.version;
      hash = prev.lib.fakeHash;
    };

    ldflags = [
      "-s"
      "-w"
      "-X main.Version=${final.cloudflared.version}"
      "-X github.com/cloudflare/cloudflared/cmd/cloudflared/updater.BuiltForPackageManager=nixpkgs"
    ];
  });
}
