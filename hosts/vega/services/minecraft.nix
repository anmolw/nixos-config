{ pkgs, inputs, ... }:
{
  imports = [ inputs.nix-minecraft.nixosModules.minecraft-servers ];
  services.minecraft-servers = {
    enable = true;
    eula = true;
    servers.vanilla = {
      enable = true;
      package = pkgs.paperServers.paper-1_21_5;
      openFirewall = true;
      autoStart = false;
      serverProperties = {
        server-port = 25565;
        difficulty = 3;
        gamemode = "survival";
        max-players = 10;
        motd = "Minecraft server";
        white-list = true;
      };
    };
  };
  sops.secrets."minecraft-whitelist" = {
    owner = "minecraft";
    path = "/srv/minecraft/vanilla/whitelist.json";
  };
}
