;; This is an operating system configuration template
;; for a "desktop" setup with GNOME and Xfce where the
;; root partition is encrypted with LUKS.

(use-modules (gnu) (nongnu packages linux) (gnu system nss) (gnu services docker))
(use-service-modules desktop xorg)
(use-package-modules certs gnome)

(operating-system
  (kernel linux)
  (firmware (list linux-firmware))
  (host-name "peter-guix-T480")
  (timezone "Asia/Hong_Kong")
  (locale "en_US.utf8")

  ;; Choose US English keyboard layout.  The "altgr-intl"
  ;; variant provides dead keys for accented characters.
  (keyboard-layout (keyboard-layout "us" "altgr-intl"))

  ;; Use the UEFI variant of GRUB with the EFI System
  ;; Partition mounted on /boot/efi.
  (bootloader (bootloader-configuration
                (bootloader grub-efi-bootloader)
                (target "/boot/efi")
                (keyboard-layout keyboard-layout)))

  ;; Specify a mapped device for the encrypted root partition.
  ;; The UUID is that returned by 'cryptsetup luksUUID'.
  (mapped-devices
   (list (mapped-device
          (source (uuid "5c2f688b-8e21-425c-b008-3684a1cfd947"))
          (target "my-root")
          (type luks-device-mapping))))

  (file-systems (append
                 (list (file-system
                         (device "/dev/mapper/my-root")
                         (mount-point "/")
                         (type "btrfs")
                         (options "compress=zstd,subvol=@")
                         (flags '(no-atime))
                         (dependencies mapped-devices))
                       (file-system
                         (device "/dev/mapper/my-root")
                         (mount-point "/home")
                         (type "btrfs")
                         (options "compress=zstd,subvol=@home")
                         (flags '(no-atime))
                         (dependencies mapped-devices))
                       (file-system
                         (device (uuid "DAA3-FBC8" 'fat32))
                         (mount-point "/boot/efi")
                         (type "vfat")))
                 %base-file-systems))

  ;; Create user `bob' with `alice' as its initial password.
  (users (cons* (user-account
                 (name "peter")
                 (comment "Peter Lo")
                 (group "users")
                 (supplementary-groups '("wheel" "netdev"
                                         "audio" "video"
					 "docker")))
                (user-account
                 (name "lemon")
                 (comment "Lemon Lin")
                 (group "users")
                 (supplementary-groups '("wheel" "netdev"
                                         "audio" "video")))
               %base-user-accounts))

  ;; This is where we specify system-wide packages.
  (packages (append (list
                     ;; for i3
                     (specification->package "i3-wm")
                     (specification->package "i3status")
                     (specification->package "dmenu")
                     (specification->package "st")
		     ;; for docker
                     (specification->package "docker-cli")
                     ;; for chinese input method
                     (specification->package "glibc-locales")
                     (specification->package "dconf")
                     (specification->package "ibus")
                     (specification->package "ibus-libpinyin")
                     (specification->package "ibus-rime")
                     ;; for HTTPS access
                     nss-certs
                     ;; for user mounts
                     gvfs)
                    %base-packages))

  ;; Add GNOME and Xfce---we can choose at the log-in screen
  ;; by clicking the gear.  Use the "desktop" services, which
  ;; include the X11 log-in service, networking with
  ;; NetworkManager, and more.
  (services (append (list (service gnome-desktop-service-type)
                          (service xfce-desktop-service-type)
			  (service docker-service-type)
                          (set-xorg-configuration
                           (xorg-configuration
                            (keyboard-layout keyboard-layout))))
                    %desktop-services))

  ;; Allow resolution of '.local' host names with mDNS.
  (name-service-switch %mdns-host-lookup-nss))
