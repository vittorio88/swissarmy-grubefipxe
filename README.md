### About swissarmy-grubefipxe
This is a little side-project of mine to be able to netboot various Operating Systems using EFI based computers and GRUB over PXE.  
I have this running on my QNAP NAS, but I believe almost any decent NAS has the requirements to run this.  
This project was born out of my disdain for flashing distros to USB keys.  

Feel free to fork and submit pull-requests!  

### Directory structure
/srv/tftp is PXE root, although it doesn't matter as long as you substitute this path in the following steps.  
There should be a NFS server and TFTP server that also expose these paths.  
My NFS server exports /srv/tftp at 1.2.3.4:/tftp where 1.2.3.4 is the IP of the NFS server.  
You should clone this repository to this path.  

`mkdir /srv/tftp/boot/grub && cd /srv/tftp/boot/`  
`git clone https://github.com/vittorio88/swissarmy-grubefipxe`  
`mv swissarmy-grubefipxe grub`  

### Install Grub and it's modules to TFTP directory
NOTE: grub must have been built with EFI support  

on ubuntu 16.04 lts:  
`mkdir -p /srv/tftp/boot/grub/x86_64-efi`  
`mkdir -p /srv/tftp/boot/grub/locale`  
`grub-mknetdir --net-directory=/srv/tftp --subdir=/boot/grub -d /usr/lib/grub/x86_64-efi`  


### Networking Configuration
Your DHCP server should be configured to point to the IP of the TFTP server.  
The DHCP server should tell PXE clients to get the file at the following path:  
`boot/grub/x86_64-efi/core.efi  `

### Troubleshooting
Make sure you are booting in EFI mode with TFTP  
Attempt to download files using another TFTP and NFS client  

### Testing notes
VMWare Workstation/Player (and probably ESXI) with firmware=efi in configuration file have a *VERY* slow/broken PXE TFTP implementation.  
Virtualbox does not support EFI PXE booting.  
KVM supports EFI PXE boot perfectly.   
I used Proxmox VE 5 for testing (KVM based) successfully.  

VMware discussion:  
https://communities.vmware.com/thread/519168  
https://communities.vmware.com/thread/564035  
https://communities.vmware.com/thread/487636  

Virtualbox discussion:  
https://forums.virtualbox.org/viewtopic.php?f=9&t=84349  

### Populate distros directory  
To keep the repository light, all distros need to be downloaded separately.  

### For FatDog live:  
`mkdir -p /srv/tftp/boot/grub/distros/fatdog`  
extract Fatdog64-721.iso to /srv/tftp/boot/grub/distros/fatdog  
  
### For arch:  
`mkdir -p /srv/tftp/boot/grub/distros/arch`  
extract archlinux-2018.01.01-x86_64.iso to /srv/tftp/boot/grub/distros/arch  
  
### For sysrescue live:  
`mkdir -p /srv/tftp/boot/grub/distros/sysrescue`  
extract ISO contents to /srv/tftp/boot/grub/distros/sysrescue  
  
### For debian-installer:  
`mkdir -p /srv/tftp/boot/grub/distros/debian-installer`  
extract net install ISO contents to /srv/tftp/boot/grub/distros/debian-installer  
  
### For ubuntu-installer:  
`mkdir -p /srv/tftp/boot/grub/distros/ubuntu-installer/xenial`  
extract net install ISO contents to /srv/tftp/boot/grub/distros/ubuntu-installer/xenial  
  
### For fedora-installer:  
`wget https://download.fedoraproject.org/pub/fedora/linux/releases/28/Workstation/x86_64/iso/Fedora-Workstation-netinst-x86_64-28-1.1.iso`  
`mkdir -p /srv/tftp/boot/grub/distros/fedora-installer`  
extract Fedora-Workstation-netinst-x86_64-27-1.6.iso to /srv/tftp/boot/grub/distros/fedora-installer  
  
### For debian-live-cinnamon:  
`mkdir -p /srv/tftp/boot/grub/distros/debian-live-cinnamon`  
extract debian-live-9.3.0-amd64-cinnamon.iso to /srv/tftp/boot/grub/distros/debian-live-cinnamon  
  
### For debian-live-gnome:  
`mkdir -p /srv/tftp/boot/grub/distros/debian-live-gnome`  
extract debian-live-9.3.0-amd64-gnome.iso to /srv/tftp/boot/grub/distros/debian-live-gnome  
  
### For debian-live-kde:  
`mkdir -p /srv/tftp/boot/grub/distros/debian-live-kde`  
extract debian-live-9.3.0-amd64-kde.iso to /srv/tftp/boot/grub/distros/debian-live-kde  
  
### For debian-live-lxde:  
`mkdir -p /srv/tftp/boot/grub/distros/debian-live-lxde`  
extract debian-live-9.3.0-amd64-lxde.iso to /srv/tftp/boot/grub/distros/debian-live-lxde  
  
### For debian-live-mate:  
`mkdir -p /srv/tftp/boot/grub/distros/debian-live-mate`  
extract debian-live-9.3.0-amd64-mate.iso to /srv/tftp/boot/grub/distros/debian-live-mate  
  
### For debian-live-xfce:  
`mkdir -p /srv/tftp/boot/grub/distros/debian-live-xfce`  
extract debian-live-9.3.0-amd64-xfce.iso to /srv/tftp/boot/grub/distros/debian-live-xfce  
