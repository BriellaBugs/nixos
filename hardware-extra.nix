{ config, pkgs, ... }:

{
  fileSystems."/mnt/windows" = {
    device = "/dev/disk/by-uuid/F03860EE3860B56E";
    fsType = "ntfs3";
    options = [
      "uid=1000"
      "gid=100"
      "umask=022"
      "nofail"
      "noatime"
      "exec"
    ];
  };

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
  };

  # Load video drivers
  services.xserver.videoDrivers = [
    "nvidia"
    "modesetting"
  ];

  boot.kernelParams = [ "nvidia.NVreg_TemporaryFilePath=/var/tmp" ];
  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management.
    powerManagement.enable = true;

    # Fine-grained power management. Turns off GPU when not in use.
    powerManagement.finegrained = true;

    # Use the NVidia open source kernel module.
    open = true;

    # Enable the Nvidia settings menu.
    nvidiaSettings = true;

    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };

      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };

    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  hardware.bluetooth.enable = true;
}
