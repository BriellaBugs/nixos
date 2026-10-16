{ config, pkgs, lib, ... }:

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
    vesktop
    yt-dlp
    tree
    mpv
    bash-completion
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

      syntax "QML" "\.qml$"
      comment "//"

      color bold,white "\<[a-z][A-Za-z0-9_.]*[[:space:]]*:"
      color brightyellow "\<[A-Z][A-Za-z0-9_.]*[[:space:]]*\{"
      color green "\<on[A-Z][A-Za-z0-9_]*\>"
      color brightmagenta "\<(import|as|property|signal|readonly|required|default|alias|component|pragma|enum|on|id)\>"
      color yellow "\<(int|real|double|string|bool|url|color|date|var|variant|list|point|size|rect|font|vector[234]d|quaternion|matrix4x4)\>"
      color brightblue "\<(function|var|let|const|if|else|for|while|do|switch|case|default|break|continue|return|new|delete|typeof|instanceof|in|of|try|catch|finally|throw|this|with)\>"
      color cyan "\<(true|false|null|undefined|NaN|Infinity)\>"
      color cyan "\<[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?\>"
      color cyan "\<0[xX][0-9a-fA-F]+\>"
      color magenta "\<(Layout|Qt|Component|Keys|Drag|ToolTip|Accessible)\.[A-Za-z0-9_]+"
      color green "\"([^\"\\]|\\.)*\""
      color green "'([^'\\]|\\.)*'"
      color green "`([^`\\]|\\.)*`"
      color gray "//.*"
      color gray start="/\*" end="\*/"
      color ,red "[[:space:]]+$"
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

  systemd.tmpfiles.rules =
    [
      "L+ /home/briella/.bashrc - - - - ${./bashrc}"
      "d /home/briella/.local/bin 0755 briella users - -"
    ]
    ++ (lib.mapAttrsToList
      (name: _: "L+ /home/briella/.local/bin/${name} - - - - ${./bin + "/${name}"}")
      (builtins.readDir ./bin))
    ++ (lib.mapAttrsToList
      (name: _: "L+ /home/briella/.local/bin/${name} - - - - ${./scripts + "/${name}"}")
      (builtins.readDir ./scripts));

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
