# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

  networking.hostName = "svij"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    vim
    curl
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
    firefox
    google-chrome
    awscli
    bpftrace
    chromium
    dhall
    dhall-json
    evince
    firefox
    fish
    flux
    gimp
    gnum4
    gnumake
    gnupg
    go
    lynx
    ncurses
    ocaml
    opam
    openjdk
    openssl
    pdftk
    protobuf
    protonvpn-gui
    python3
    ruby
    sbt
    scala
    shellcheck
    slack
    terminator
    thunderbird
    tig
    tmux
    vscode
    wine
    zoom
    google-cloud-sdk
    gh
  ];

  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
  };

  # List services that you want to enable:

  services.openssh.enable = true;
  programs.ssh.agentTimeout = "12h";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.xkbOptions = "caps:ctrl_modifier";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.guest = {
    isNormalUser = true;
    uid = 1000;
  };

  users.extraUsers.svij = {
    isNormalUser = true;
    group = "users";
    createHome = true;
    uid = 1001;
    extraGroups = [ "wheel" "docker" ];
  };
  users.extraGroups.docker.members = [ "svij" ];

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "16.09";

  virtualisation.docker.enable = true;
  virtualisation.docker.storageDriver = "devicemapper";
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "svij" ];
  # https://www.gordonmac.com/auto-mounting-an-apple-airport-extreme-disk-volume-on-a-raspberry-pi/
  #
  fileSystems."/mnt/airport" = {
      device = "//10.0.1.1/Data";
      fsType = "cifs";
      options = let
        # this line prevents hanging on network split
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,sec=ntlm";

      in ["${automount_opts},credentials=/etc/nixos/smb-secrets"];
  };
}
