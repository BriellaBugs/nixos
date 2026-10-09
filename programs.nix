{ config, pkgs, ... }:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    lon
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

#  pkgs.sddm-astronaut.override = { embeddedTheme = "japanese_aesthetic"; };

  environment.etc."xdg/kitty/kitty.conf".source = ./kitty.conf;

  programs.kdeconnect.enable = true;

  programs.nano = {
    enable = true;
    nanorc = ''
      set nowrap
      set tabstospaces
      set tabsize 2
      set historylog
      set magic
      set nohelp
      set positionlog
      set smarthome
      set zap
      set autoindent
      set linenumbers
      set stateflags
      set errorcolor bold,white,red
      set numbercolor crimson,normal
      set selectedcolor white,purple
      set spotlightcolor black,lightyellow
      set titlecolor bold,white,crimson
    ''; 
  };

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

  programs.gamemode.enable = true;

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
