{ config, pkgs, ... }:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    nano
    wget
    lshw
    kitty
    sbctl
    zapzap
    iw
    inkscape
    wl-clipboard
    sddm-astronaut
  ];

  environment.etc."xdg/kitty/kitty.conf".source = ./kitty.conf;

  programs.kdeconnect.enable = true;

  # Key Remapping
  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "*" ];
        settings = {
          main = {
            capslock = "tab";
          };
        };
      };
    };
  };

  # Steam
  programs.steam = {
    enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
  };

  # Firefox
  programs.firefox = {
    enable = true;
    policies = {
      DisableTelemetry = true;
      DisablePocket = true;
    };
  };

  programs.bash = {
    enable = true;
    completion.enable = true;
  };
  systemd.tmpfiles.rules = [
    "L+ /home/briella/.bashrc - - - - ${./bashrc}"
  ];

  # VR
  services.wivrn = {
    enable = true;
    openFirewall = true;
  };

  programs.git = {
    enable = true;
    lfs.enable = true;
  };
}
