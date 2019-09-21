;;; adapted from https://github.com/chrispoole643/etc/blob/master/emacs/.emacs.d/init.el

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Emacs Configuration
;;;; ===================
;;;;
;;;; Bootstrapping setup to be able to load the content kept in org-mode
;;;; files. Loads generally-required files first, then those that are
;;;; platform-specific.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Define org and melpa as package sources, and install `use-package' if it's not
;;; already there. Always ensure packages being loaded are there (or else it'll
;;; automatically download from melpa)

(require 'package)
(setq user-emacs-directory "~/.emacs.d/")
(setq package-user-dir (concat user-emacs-directory "packages"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
(when (>= emacs-major-version 25)
  (setq package-archive-priorities '(("org" . 3)
								     ("melpa" . 2)
								     ("gnu" . 1))))
(setq package-load-list '(all))
(package-initialize)
(setq package-enable-at-startup nil)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(setq use-package-always-ensure t)
(add-hook 'package-menu-mode-hook 'hl-line-mode)

;;; Load org mode early to ensure that the orgmode ELPA version gets picked up, not the
;;; shipped version
(use-package org
  :ensure org-plus-contrib
  :pin org
  :config
  (require 'org-tempo))

;;; Check to see if running on Mac OS X or some GNU/Linux distro
(defvar macosxp (string-match "darwin" (symbol-name system-type)))
(defvar linuxp (string-match "gnu/linux" (symbol-name system-type)))
(defvar workp (string-match "ibm" (system-name)))

;;; Add lisp directory tree to load-path
;(setq load-path (append (cjp-get-dir-structure-in "lisp") load-path))

;;;;;;
;;; legacy settings
(require 'cl)

;;;;;;

;;;;;;
(setq sh-indent-comment t)

;;;;;;
;;; for quick lookup of man page and hyperspec
(global-set-key  [f6] (lambda () (interactive) (manual-entry (current-word))))

(global-set-key  [f7] 'common-lisp-hyperspec)
(setq common-lisp-hyperspec-root "file:/usr/share/doc/hyperspec/")
;;;;;;
;;; compilation
(global-set-key (kbd "C-c c") 'compile)

;;;;;;
;; SBCL and slime
(use-package slime
  :ensure t
  :config
  (setq inferior-lisp-program "/usr/bin/sbcl --dynamic-space-size 2048")
  (slime-setup '(slime-fancy)))

;; magit
(use-package magit
  :bind (("C-x g" . magit-status)))

;;
(use-package ess
  :ensure t
  :init (require 'ess-site))

;;;;;;
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "DejaVu Sans Mono" :foundry "unknown" :slant normal :weight normal :height 120 :width normal)))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#0a0814" "#f2241f" "#67b11d" "#b1951d" "#4f97d7" "#a31db1" "#28def0" "#b2b2b2"])
 '(column-number-mode t)
 '(custom-enabled-themes nil)
 '(custom-safe-themes
   (quote
    ("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default)))
 '(electric-indent-mode nil)
 '(hl-todo-keyword-faces
   (quote
    (("TODO" . "#dc752f")
     ("NEXT" . "#dc752f")
     ("THEM" . "#2d9574")
     ("PROG" . "#4f97d7")
     ("OKAY" . "#4f97d7")
     ("DONT" . "#f2241f")
     ("FAIL" . "#f2241f")
     ("DONE" . "#86dc2f")
     ("NOTE" . "#b1951d")
     ("KLUDGE" . "#b1951d")
     ("HACK" . "#b1951d")
     ("TEMP" . "#b1951d")
     ("FIXME" . "#dc752f")
     ("XXX" . "#dc752f")
     ("XXXX" . "#dc752f")
     ("???" . "#dc752f"))))
 '(indent-tabs-mode nil)
 '(org-agenda-files (quote ("~/todo.org")))
 '(org-export-backends (quote (ascii beamer html icalendar latex)))
 '(org-odt-preferred-output-format "pdf")
 '(package-selected-packages
   (quote
    (counsel-projectile projectile counsel ivy org-plus-contrib org-link-minor-mode ox-hugo ob-ipython ob-mongo ob-prolog ob-sagemath ob-sql-mode spacemacs-theme magit slime org-ref markdown-mode ess auctex)))
 '(pdf-view-midnight-colors (quote ("#b2b2b2" . "#292b2e")))
 '(safe-local-variable-values (quote ((Base . 10) (Syntax . ANSI-Common-Lisp))))
 '(select-enable-primary t)
 '(show-paren-mode t)
 '(warning-suppress-types (quote ((:warning \(undo\ discard-info\))))))

;;;;;;
;;; for sql-mode
(add-hook 'sql-interactive-mode-hook
          (lambda ()
            (toggle-truncate-lines t)))

;;;;;;
;;(setq org-latex-pdf-process (list "latexmk -pdf -bibtex %f"))
(setq org-latex-pdf-process (list "makepdf.sh %f"))

(add-hook 'org-mode-hook #'visual-line-mode)

;;;;;;
;; C family
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(setq-default c-basic-offset 4
			  tab-width 4
			  indent-tabs-mode nil)

(setq c-default-style 
	  '((java-mode . "java")
		(awk-mode . "awk")
		(other . "linux")))
(c-set-offset 'substatement-open 0)
;;

;;;;;;
;; Octave
(setq auto-mode-alist
      (cons '("\\.m$" . octave-mode) auto-mode-alist))

;;;;;;
(setq column-number-mode t)

(setq python-shell-interpreter "python3")

;;;;;;
;;
;(add-hook 'after-init-hook (lambda () (load-theme 'spacemacs-dark)))

;;;;;;
;; babel
(org-babel-do-load-languages
 'org-babel-load-languages
 '((R . t)
   (C . t)
   (emacs-lisp . t)
   (lisp . t)
   (scheme . t)
   (python . t)
   (sql . t)
   (shell . t)
   (sh . t)
   (awk . t)
   (sed . t)
   (css . t)
   (ditaa . t)
   (makefile . t)
   (org . t)
   ))
(setq org-babel-python-command "python3")
(setq org-ditaa-jar-path "/usr/share/emacs/25.3/lisp/org/ditaa.jar")
(setq org-confirm-babel-evaluate nil)

;;;;;;
(use-package ox-hugo
  :ensure t            ;Auto-install the package from Melpa (optional)
  :after ox)

;;;;;;
;;(use-package ivy
;;  :ensure t
;;  :diminish (ivy-mode . "")
;;  :config
;;  (ivy-mode 1)
;;  (setq ivy-use-virtual-buffers t)
;;  (setq enable-recursive-minibuffers t)
;;  (setq ivy-height 10)
;;  (setq ivy-initial-inputs-alist nil)
;;  (setq ivy-count-format "%d/%d ")
;;  (setq ivy-re-builders-alist
;;        `((t . ivy--regex-ignore-order)))
;;  )
;;
;;(use-package counsel
;;  :ensure t
;;  :bind (("M-x" . counsel-M-x)
;;         ("\C-x \C-f" . counsel-find-file))
;;  )

;;;;;;
;;(use-package projectile
;;  :ensure t
;;  :bind-keymap ("\C-c p" . projectile-command-map)
;;  :config
;;  (projectile-mode t)
;;  (setq projectile-completion-system 'ivy)
;;  (use-package counsel-projectile
;;    :ensure t)
;;  )

;;;;;;
(use-package auctex
  :ensure t
  :defer t
  )

;;;;;;
