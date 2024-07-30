;; This is an operating system configuration template
;; for a "desktop" setup with GNOME and Xfce where the
;; root partition is encrypted with LUKS, and a swap file.

(use-modules (gnu) (nongnu packages linux)
             (gnu system nss) (gnu services docker)
             (gnu system mapped-devices)
             (guix utils))
(use-service-modules desktop xorg)
(use-package-modules certs gnome)

(operating-system
  (kernel linux)
  (firmware (list linux-firmware))
  (host-name "peter-guix-E495")
  (timezone "Asia/Hong_Kong")
  (locale "en_US.utf8")

  ;; Choose US English keyboard layout.  The "altgr-intl"
  ;; variant provides dead keys for accented characters.
  (keyboard-layout (keyboard-layout "us" "altgr-intl"))

  ;; Use the UEFI variant of GRUB with the EFI System
  ;; Partition mounted on /boot/efi.
  (bootloader (bootloader-configuration
                (bootloader grub-efi-bootloader)
                (targets '("/boot/efi"))
                (keyboard-layout keyboard-layout)))

  ;; Specify a mapped device for the encrypted root partition.
  ;; The UUID is that returned by 'cryptsetup luksUUID'.
  (mapped-devices
   (list (mapped-device
          (source (uuid "e8ed2b99-696c-47f0-b130-57581da3fe96"))
          (target "my-root")
          (type luks-device-mapping))
         (mapped-device
          (source (uuid "5506d5dd-0821-4ef2-a714-011cb6d86fe7"))
          (target "large")
          (type (luks-device-mapping-with-options
                 #:key-file "/mykeyfile")))))

  (file-systems (append
                 (list (file-system
                         (device "/dev/mapper/my-root")
                         (mount-point "/")
                         (type "btrfs")
                         (options "compress=zstd,subvol=@")
                         (flags '(no-atime))
                         ;; only need the first drive for root and home
                         (dependencies (list (car mapped-devices))))
                       (file-system
                         (device "/dev/mapper/my-root")
                         (mount-point "/home")
                         (type "btrfs")
                         (options "compress=zstd,subvol=@home")
                         (flags '(no-atime))
                         ;; only need the first drive for root and home
                         (dependencies (list (car mapped-devices))))
                       (file-system
                         (device "/dev/mapper/large")
                         (mount-point "/home/peter/large")
                         (type "btrfs")
                         (options "compress=zstd,subvol=@large")
                         (flags '(no-atime))
                         (dependencies mapped-devices))
                       (file-system
                         (device (uuid "F23E-39FA" 'fat32))
                         (mount-point "/boot/efi")
                         (type "vfat")))
                 %base-file-systems))

  ;; Specify a swap file for the system, which resides on the
  ;; root file system.
  (swap-devices (list (swap-space
                       (target "/var/swapfile"))))

  ;; Create user `bob' with `alice' as its initial password.
  (users (cons (user-account
                (name "peter")
                (comment "Peter Lo")
                (group "users")
                (supplementary-groups '("wheel" "netdev"
                                        "audio" "video"
                                        "docker")))
               %base-user-accounts))

  ;; Add the `students' group
  (groups (cons* (user-group
                  (name "users"))
                 %base-groups))

  ;; This is where we specify system-wide packages.
  (packages (append (list
                     (specification->package "i3-wm")
                     (specification->package "i3status")
                     (specification->package "dmenu")
                     (specification->package "st")
                     (specification->package "docker-cli")
                     (specification->package "glibc-locales")
                     (specification->package "dconf")
                     (specification->package "ibus")
                     (specification->package "ibus-libpinyin")
                     (specification->package "ibus-rime")
                     (specification->package "rime-data")

                     ;; for HTTPS access
                     ;;nss-certs
                     ;; for user mounts
                     gvfs)
                    %base-packages))

  ;; Add GNOME and Xfce---we can choose at the log-in screen
  ;; by clicking the gear.  Use the "desktop" services, which
  ;; include the X11 log-in service, networking with
  ;; NetworkManager, and more.
  (services (if (target-x86-64?)
                (append (list (service gnome-desktop-service-type)
                              (service xfce-desktop-service-type)
                              (service docker-service-type)
                              (set-xorg-configuration
                               (xorg-configuration
                                (keyboard-layout keyboard-layout))))
                        %desktop-services)

                ;; FIXME: Since GDM depends on Rust (gdm -> gnome-shell -> gjs
                ;; -> mozjs -> rust) and Rust is currently unavailable on
                ;; non-x86_64 platforms, we use SDDM and Mate here instead of
                ;; GNOME and GDM.
                (append (list (service mate-desktop-service-type)
                              (service xfce-desktop-service-type)
                              (service docker-service-type)
                              (set-xorg-configuration
                               (xorg-configuration
                                (keyboard-layout keyboard-layout))
                               sddm-service-type))
                        %desktop-services)))

  ;; Allow resolution of '.local' host names with mDNS.
  (name-service-switch %mdns-host-lookup-nss))
