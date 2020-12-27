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
            ;; for the chinese input method
            (specification->package "glibc-locales")
            (specification->package "dconf")
            (specification->package "ibus")
            (specification->package "ibus-libpinyin")
            (specification->package "ibus-rime")
            ;;(specification->package "fcitx5")
            ;;(specification->package "fcitx5-configtool")
            ;;(specification->package "fcitx5-chinese-addons")
            ;;(specification->package "fcitx5-qt")
            ;;(specification->package "fcitx5-gtk")
            ;;
            (specification->package "st")
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
      (bootloader grub-bootloader)
      (target "/dev/sda")
      (keyboard-layout keyboard-layout)))
  (swap-devices
    (list (uuid "af8d4e0c-0d47-49e2-b822-e32a6d8d9726")))
  (file-systems
    (cons* (file-system
             (mount-point "/")
             (device
               (uuid "21c472b6-da69-49b1-b030-e4683787409c"
                     'ext4))
             (type "ext4"))
           %base-file-systems)))
