# nixos 

## Installing on M1 Mac

### Pick a Hypervisor
* Parallels - didn't explored
* Vmware fusion (preferred) - suppose to have better perfomance
* UTM backed by Qemo - AFAICT, not a hypervisor; it does emulation. So, likely slower than Vmware fusion

### Installation
* Install hypervisor
* Download Nixos ARM ISO from [here](https://nixos.wiki/wiki/NixOS_on_ARM/UEFI#Getting_the_installer_image_.28ISO.29)
* Create a custom vm (applicable in the case of fusion)
* Follow install instructions [here](https://nixos.wiki/wiki/NixOS_on_ARM/UEFI#Installing)

#### Intall standalone home manager
* https://nix-community.github.io/home-manager/index.html#sec-install-standalone

### Issues
* Broken pipe failed on Vmware fusion because /tmp was owned by root

## Running x86 images on ARM
* https://www.stereolabs.com/docs/docker/building-arm-container-on-x86/
* https://github.com/multiarch/qemu-user-static


## TODOs
* Migrate to use home manager and flake

## References
* https://nixos.wiki/wiki/Cheatsheet
* https://nixos.wiki/wiki/Home_Manager
* https://nixos.wiki/wiki/Home_Manager
* https://search.nixos.org/options
* https://blogs.vmware.com/teamfusion/2021/09/fusion-for-m1-public-tech-preview-now-available.html
* https://kb.vmware.com/s/article/80467
* https://nixos.org/manual/nixos/stable/index.html#sec-installation
* https://nixos.wiki/wiki/NixOS_on_ARM/UEFI
* https://nixos.org/manual/nixos/stable/index.html#sec-installation
* https://communities.vmware.com/t5/Fusion-for-Apple-Silicon-Tech/nixos-does-not-have-dev-sda-in-VMWare-Fusion-Tech-Preview-M1/m-p/2883393#M488
