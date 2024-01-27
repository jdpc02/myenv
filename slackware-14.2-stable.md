# Setup Slackware 14.2 Stable
## Sources
* [Slackware Documentation Project](https://docs.slackware.com/start)
* [Post-Install](https://docs.slackware.com/slackware:beginners_guide)
* [Multilib Setup](https://docs.slackware.com/slackware:multilib)
* [Sync Time](https://docs.slackware.com/howtos:hardware:syncing_hardware_clock_and_system_local_time)
* [slackpkg+](http://slakfinder.org/slackpkg+.html)
## Setup
1. Install slackware 14.2 based on the SDP.
2. Setup non-root user:
    * Create a user via adduser. Ensure you add it to the default groups (lp,floppy,audio,video,cdrom,plugdev,power,netdev,scanner).
    * Create a group called sudo via groupadd.
    * Add user to sudo via usermod -aG sudo <user>
	* Modify /etc/sudoers and uncomment %sudo ALL=(ALL) ALL
3. Sync your time:
    ```
	# ntpdate pool.ntp.org
	# hwclock --systohc --localtime
	```
3. Update the system:
    * Modify /etc/slackpkg/mirrors to specify the slackware mirror you want to use.
	* Run the following commands with sudo:
        ```	
        # slackpkg update gpg
        # slackpkg update
        # slackpkg install-new
        # slackpkg upgrade-all
        # slackpkg clean-system # Only after post-distribution upgrade
        ```
4. Setup multilib:
    * Download the multilib packages with the following commands.
	    ```
		# SLACKVER=14.2
		# mkdir multlib
		# cd multilib
		# lftp -c "open https://bear.alienbase.nl/mirrors/people/alien/multilib/ ; mirror -c -e ${SLACKVER}"
		# cd ${SLACKVER}
		```
	* Install packages:
	    ```
		# upgradepkg --reinstall --install-new *.t?z
		# upgradepkg --install-new slackware64-compat32/*-compat32/*.t?z
		```
	* Setup slackpkg+
	    1. Install software:
	        ```
		    # wget https://sourceforge.net/projects/slackpkgplus/files/slackpkg%2B-1.7.0-noarch-12mt.txz
		    # installpkg slackpkg+-1.7.0-noarch-12mt.txz
		```
            2. Configure /etc/slackpkg/slackpkgplus.conf by uncommenting and/or modifying the following lines:
                * PKGS_PRIORITY=( multilib )
                * REPOPLUS=(slackpkgplus multilib)
                * MIRRORPLUS['multilib']=https://bear.alienbase.nl/mirrors/people/alien/multilib/14.2/
                * MIRRORPLUS['slackpkgplus']=https://slakfinder.org/slackpkg+dev/
            3. Blacklist slackpkg+ for now as 1.7.4 complains about distribution. This is in prepartion for slackware-15.
5. Rerun updates.
6. Use generic kernel to minimize RAM usage.
    ```
    # /usr/share/mkinitrd/mkinitrd_command_generator.sh -k <kernel_version> # This gives the command to run to generate the initrd file
    # mkinitrd -c -k 4.4.240 -f ext4 -r /dev/<root_partition> -m mptbase:mptscsih:mptspi:jbd2:mbcache:ext43 usb-storage:ehci-hcd:usbhid:ohci-hcd:mbcache:jbd2:ext4 -u -o /boot/initrd.gz
    # /usr/share/mkinitrd/mkinitrd_command_generator.sh -l /boot/vmkernel-generic # This recommends the lilo entries to be added
    # lilo -v
    ```
   Whenever the kernel is updated, you need to regenerate the initrd.gz entry.

