# Nixos

## Installing on M1 Mac

### Hypervisors
* Vmware fusion (preferred)
* Parallels
* UTM backed by Qemo (not a hypervisor; does emulation. So, likely slower than Vmware fusion)

### Installation on hypervisor
* Install hypervisor
* Download Nixos ARM ISO from [here](https://nixos.wiki/wiki/NixOS_on_ARM/UEFI#Getting_the_installer_image_.28ISO.29)
* Create a custom vm (applicable in the case of fusion)
* Follow install instructions [here](https://nixos.wiki/wiki/NixOS_on_ARM/UEFI#Installing)

## Installing on Mac

* Create a bootup USB drive using dd command with ISO(https://nixos.wiki/wiki/NixOS_Installation_Guide)
```
dd if=nixos.iso of=/dev/sdX bs=4M status=progress conv=fdatasync
```
* Boot from UEFI
* Follow Install instructions [here](https://nixos.org/manual/nixos/stable/index.html#sec-installation)
  * Remember to enable Gnome in the default configuration
  * Add svij user

## Setup dev environment
* Clone home repo
* Create github key (using make) and upload to github

## References
* https://blogs.vmware.com/teamfusion/2021/09/fusion-for-m1-public-tech-preview-now-available.html
* https://kb.vmware.com/s/article/80467
* https://nixos.org/manual/nixos/stable/index.html#sec-installation
* https://nixos.wiki/wiki/NixOS_on_ARM/UEFI
* https://nixos.org/manual/nixos/stable/index.html#sec-installation
* https://communities.vmware.com/t5/Fusion-for-Apple-Silicon-Tech/nixos-does-not-have-dev-sda-in-VMWare-Fusion-Tech-Preview-M1/m-p/2883393#M488
