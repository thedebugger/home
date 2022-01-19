# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      #./adhoc.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda";
  boot.cleanTmpDir = true;

  fonts.enableCoreFonts = true;

  networking.hostName = "svij-laptop"; # Define your hostname.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = false;
  networking.extraHosts = ''
    127.0.0.1 svij-laptop
  '';

  services.openvpn.servers.client = {
    config = builtins.readFile /home/svij/Downloads/new_corp_client.ovpn;
    # hardcode nameserver if $nameserver doesn't work.
    up = "echo nameserver $nameserver | ''${pkgs.openresolv}/sbin/resolvconf -m 0 -a $dev";
    down = "''${pkgs.openresolv}/sbin/resolvconf -d $dev";
    autoStart = false;
  };

  hardware.pulseaudio.enable = true;
  hardware.bluetooth.enable = true;

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  boot.extraModprobeConfig = ''
    options snd slots=snd-hda-intel
  '';
  boot.kernelModules = [
    "thunderbolt"
  ];

  environment.systemPackages = with pkgs; [
    vim
    fish
    wget
    git
    chromium
    htop
    terminator
    gnused
    coreutils
    xclip
    tig
    zip
    unzip
    jq
    tree
    which
    file
    weechat
    vagrant
    gnumake
    google-cloud-sdk
  ];

  services.zookeeper.enable = false;
  services.zookeeper.preferIPv4 = true;

  nixpkgs.config = {
    allowUnfree = true;
    chromium.enablePepperFlash = true;
    chromium.enableWideVine = true;
    firefox.enableAdobeFlash = true;
    packageOverrides = pkgs: {
	bluez = pkgs.bluez5;
    };
  };

  # List services that you want to enable:

  services.openssh.enable = true;
  programs.ssh.agentTimeout = "12h";

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "caps:ctrl_modifier";

  services.xserver.desktopManager.gnome3.enable = true;

  # Enable the KDE Desktop Environment.
  services.xserver.desktopManager.kde5.enable = false;
  services.xserver.vaapiDrivers = [ pkgs.vaapiIntel ];
  services.xserver.multitouch.invertScroll = true;

  services.xserver.synaptics = {
    enable = true;
    twoFingerScroll = true;
    #buttonsMap = [ 1 3 2 5 4 ];
    vertEdgeScroll = false;
    palmDetect = true;
    minSpeed = "0.8";
    maxSpeed = "1.4";
  };

  users.extraUsers.svij = {
    isNormalUser = true;
    group = "users";
    createHome = true;
    uid = 1000;
    extraGroups = [ "wheel" ];
  };

  users.defaultUserShell = "/run/current-system/sw/bin/bash";
  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "15.09";

  virtualisation.docker.enable = true;
  virtualisation.docker.storageDriver = "devicemapper";
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "svij" ];
}
