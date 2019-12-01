;; This is an operating system configuration generated
;; by the graphical installer.

(use-modules (gnu))
(use-service-modules desktop networking ssh xorg)
(use-package-modules bootloaders certs suckless wm)

(operating-system
  (locale "en_HK.utf8")
  (timezone "Asia/Hong_Kong")
  (keyboard-layout
    (keyboard-layout "us" "altgr-intl"))
  (bootloader
    (bootloader-configuration
      (bootloader grub-bootloader)
      (target "/dev/sda")
      (keyboard-layout keyboard-layout)))
  (swap-devices (list "/dev/sda2"))
  (file-systems
    (cons* (file-system
             (mount-point "/")
             (device
               (uuid "d8286c7f-f716-44e4-96ff-adfdd1b15a94"
                     'ext4))
             (type "ext4"))
           %base-file-systems))
  (host-name "peter_guix")
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
      (list
       i3-wm i3status dmenu
       ;;
       (specification->package "nss-certs"))
      %base-packages))
  (services
    (append
      (list (service xfce-desktop-service-type)
            (set-xorg-configuration
              (xorg-configuration
                (keyboard-layout keyboard-layout))))
      %desktop-services)))
