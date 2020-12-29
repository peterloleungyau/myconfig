;; This is an operating system configuration generated
;; by the graphical installer.

(use-modules (gnu))
(use-service-modules desktop networking ssh xorg)

(operating-system
  (locale "en_US.utf8")
  (timezone "Asia/Hong_Kong")
  (keyboard-layout (keyboard-layout "us"))
  (host-name "peter-guix")
  (users (cons* (user-account
                  (name "peter")
                  (comment "Peter")
                  (group "users")
                  (home-directory "/home/peter")
                  (supplementary-groups
                    '("wheel" "netdev" "audio" "video")))
                %base-user-accounts))
  (packages
    (append
      (list (specification->package "openbox")
            (specification->package "i3-wm")
            (specification->package "i3status")
            (specification->package "dmenu")
            (specification->package "st")
	    ;; for chinese input method
            (specification->package "glibc-locales")
            (specification->package "dconf")
            (specification->package "ibus")
            (specification->package "ibus-libpinyin")
            (specification->package "ibus-rime")
            ;;
            (specification->package "nss-certs"))
      %base-packages))
  (services
    (append
      (list (service xfce-desktop-service-type)
            (set-xorg-configuration
              (xorg-configuration
                (keyboard-layout keyboard-layout))))
      %desktop-services))
  (bootloader
    (bootloader-configuration
      (bootloader grub-efi-bootloader)
      (target "/boot/efi")
      (keyboard-layout keyboard-layout)))
  (swap-devices
    (list (uuid "ce68ef2d-0b67-4adc-90ff-5727388a9322")))
  (file-systems
    (cons* (file-system
             (mount-point "/home")
             (device
               (uuid "880c9b8b-b505-4895-8aa8-ca2ea063f42f"
                     'ext4))
             (type "ext4"))
           (file-system
             (mount-point "/")
             (device
               (uuid "06f7b7d2-5466-4509-b336-002ec27cf280"
                     'ext4))
             (type "ext4"))
           (file-system
             (mount-point "/boot/efi")
             (device (uuid "1CF7-0888" 'fat32))
             (type "vfat"))
           %base-file-systems)))
