
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(require 'package)
(package-initialize)
;;(add-to-list 'package-archives
;;             '("melpa-stable" . "https://stable.melpa.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(package-initialize)
(setq package-enable-at-startup nil)

(setq exec-path (append exec-path '("/usr/local/bin")))
;; from https://stackoverflow.com/questions/8606954/path-and-exec-path-set-but-emacs-does-not-find-executable
(defun set-exec-path-from-shell-PATH ()
  "Set up Emacs' `exec-path' and PATH environment variable to match that used by the user's shell.

This is particularly useful under Mac OSX, where GUI apps are not started from a shell."
  (interactive)
  (let ((path-from-shell (replace-regexp-in-string "[ \t\n]*$" "" (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

(set-exec-path-from-shell-PATH)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-enabled-themes (quote (spacemacs-dark)))
 '(custom-safe-themes
   (quote
    ("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default)))
 '(delete-by-moving-to-trash t)
 '(dired-dwim-target t)
 '(dired-isearch-filenames (quote dwim))
 '(dired-listing-switches "-aAFhlv")
 '(dired-recursive-copies (quote always))
 '(dired-subtree-use-backgrounds nil t)
 '(elpy-modules
   (quote
    (elpy-module-company elpy-module-eldoc elpy-module-pyvenv elpy-module-highlight-indentation elpy-module-yasnippet elpy-module-django elpy-module-sane-defaults)))
 '(org-agenda-files
   (quote
    ("~/Documents/personal/notes/inbox.org" "~/Documents/personal/notes/nlp.org" "~/Documents/personal/notes/pollution.org" "~/Documents/personal/notes/critical_illness.org" "~/Documents/personal/notes/mortality.org" "~/Documents/personal/notes/underwriting.org")))
 '(org-export-backends (quote (ascii html icalendar latex md odt)))
 '(org-odt-preferred-output-format "pdf")
 '(package-selected-packages
   (quote
    (org-evil linum-relative autopair evil-surround evil dired-subtree image+ vdiff yasnippet-snippets flycheck lsp-ui lsp-mode company-lsp dash dockerfile-mode markdown-mode use-package ess-R-data-view elpygen ox-hugo spacemacs-theme ess yaml-mode magit anaconda-mode elpy)))
 '(show-paren-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq org-agenda-files '("~/Documents/personal/notes/inbox.org"
			 "~/Documents/personal/notes/nlp.org"
			 "~/Documents/personal/notes/pollution.org"
			 "~/Documents/personal/notes/critical_illness.org"
			 "~/Documents/personal/notes/mortality.org"
			 "~/Documents/personal/notes/underwriting.org"
			 ))

(setq org-capture-templates '(("t" "Todo [inbox]" entry
                               (file+headline "~/Documents/personal/notes/inbox.org" "Tasks")
                               "* TODO %i%?")
                              ("h" "Howto" entry
                               (file+headline "~/Documents/personal/learning_notes/learning.org" "HowTo")
                               "* %i%?")
                              ))

;; prevent auto-insert extra newline in list
(setq org-blank-before-new-entry '((heading) (plain-list-item)))

(setq org-refile-targets '((org-agenda-files . (:maxlevel . 1))))

(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)

(add-hook 'org-mode-hook 'visual-line-mode)

;;(elpy-enable)

(add-hook 'python-mode-hook 'anaconda-mode)
;;(add-hook 'python-mode-hook 'anaconda-eldoc-mode)

;;
(global-set-key (kbd "C-x g") 'magit-status)

;;
(set-background-color "gray")
(set-default-font "Menlo 18")

;; for pdflatex
(setenv "PATH" (concat (getenv "PATH") ":/Library/TeX/texbin"))

;;
(add-hook 'after-init-hook (lambda () (load-theme 'spacemacs-dark)))

;; ox-hugo
(with-eval-after-load 'ox
  (require 'ox-hugo))

;; for C++
(setq-default indent-tabs-mode nil)

;;
(require 'ess)
(require 'ess-site)
(defun my-ess-settings ()
  (setq ess-indent-with-fancy-comments nil)
  (ess-set-style 'RStudio)
  (setq ess-offset-arguments 'open-delim)
  (setq ess-indent-level 2)
  (setq ess-indent-offset 2)
  (setq ess-arg-function-offset t))
(my-ess-settings)
(define-key ess-r-mode-map (kbd "C-c v") #'ess-R-dv-ctable)
(define-key inferior-ess-r-mode-map (kbd "C-c v") #'ess-R-dv-ctable)
(add-hook 'ess-mode-hook #'my-ess-settings)
(setq ess-history-file nil)
(setq tab-always-indent 'complete)

;; copied and modified from
;;  https://emacs.stackexchange.com/questions/8041/how-to-implement-the-piping-operator-in-ess-mode
(defun then-R-operator ()
  "R - %>% operator or 'then' pipe operator"
  (interactive)
  (just-one-space 1)
  (insert "%>% "))
(define-key ess-mode-map (kbd "M-M") 'then-R-operator)
(define-key inferior-ess-mode-map (kbd "M-M") 'then-R-operator)
(define-key ess-mode-map (kbd "s-M") 'then-R-operator)
(define-key inferior-ess-mode-map (kbd "s-M") 'then-R-operator)

(defun my-R-assign ()
  "R - <- operator"
  (interactive)
  (just-one-space 1)
  (insert "<- "))
(define-key ess-r-mode-map (kbd "M--") #'my-R-assign)
(define-key inferior-ess-r-mode-map (kbd "M--") #'my-R-assign)
;;

(setq inferior-R-program-name "/usr/local/bin/R")

;;
(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

;;
(use-package projectile
  :ensure t
  :config
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (projectile-mode +1))
(setq projectile-project-search-path '("~/Documents/projects/" "~/Documents/personal/"))

;;
(use-package yasnippet
  :ensure t
  :config
  (use-package yasnippet-snippets
    :ensure t)
  (yas-global-mode 1)
  (add-to-list 'yas-snippet-dirs "~/Documents/personal/myconfig/snippets/")
  (yas-reload-all)
  )

;;(setq python-shell-interpreter "/anaconda/envs/myenv/bin/python")
(setq python-shell-interpreter "python")

(setq lsp-clients-python-command "/anaconda/envs/myenv/bin/pyls")
(use-package lsp-mode
  :ensure t
  ;; :hook (python-mode . lsp)
  :commands lsp)
(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)
(use-package company-lsp
  :ensure t
  :commands company-lsp)

(setenv "PYTHONIOENCODING" "utf-8")

(use-package elpy
  :ensure t
  :defer t
  :init
  (advice-add 'python-mode :before 'elpy-enable)
  :config
  :bind (:map python-mode-map
              ("<C-return>" . python-shell-send-region))
  )

;; tramp X forwarding
(with-eval-after-load 'tramp
  (add-to-list 'tramp-methods
               '("sshx11"
                 (tramp-login-program        "ssh")
                 (tramp-login-args           (("-l" "%u") ("-p" "%p") ("%c")
                                              ("-e" "none") ("-X") ("%h")))
                 (tramp-async-args           (("-q")))
                 (tramp-remote-shell         "/bin/sh")
                 (tramp-remote-shell-login   ("-l"))
                 (tramp-remote-shell-args    ("-c"))
                 (tramp-gw-args              (("-o" "GlobalKnownHostsFile=/dev/null")
                                              ("-o" "UserKnownHostsFile=/dev/null")
                                              ("-o" "StrictHostKeyChecking=no")
                                              ("-o" "ForwardX11=yes")))
                 (tramp-default-port         22)))
  (tramp-set-completion-function "sshx11" tramp-completion-function-alist-ssh))

;;
(require 'vdiff)
(define-key vdiff-mode-map (kbd "C-c") vdiff-mode-prefix-map)

;;
(eval-after-load 'image '(require 'image+))
(eval-after-load 'image+ '(imagex-global-sticky-mode 1))
(eval-after-load 'image+ '(imagex-auto-adjust-mode 1))

;;
(require 'cl) ;; otherwise give error on incf
(defun occur-multi-strs-engine (regexps)
  ;; returns a hash table of line-beg => (occurrence-count "matched-line" (word-beg . word-end) ...)
  ;; of the occurrences of the list of regexps
  (let* ((found-match-lines (make-hash-table))
         ;; use line beginning position as key
         word-end
         (orig-beg-pt (point-min))
         (orig-line-no (line-number-at-pos orig-beg-pt))
         cur-line-no
         prev-pt
         )
    (save-excursion
      (dolist (regexp regexps found-match-lines)
        (setq prev-pt orig-beg-pt)
        (goto-char prev-pt)
        (setq cur-line-no orig-line-no)
        (while (and (not (eobp))
                    (setq word-end (re-search-forward regexp nil t)))
          (let* ((line-beg (line-beginning-position))
                 (line-end (line-end-position))
                 (word-pos (cons (match-beginning 0) word-end))
                 (entry (gethash line-beg found-match-lines nil)))
            (if entry
                ;; entry is (occurrence-count line-no "matched-line" (word-beg . word-end) ...)
                ;; add new occurrence to the matched line
                (progn
                  (incf (car entry))
                  (push word-pos (cdddr entry))
                  ;; get the line-no, so no need to count
                  (setq cur-line-no (second entry))
                  (setq prev-pt line-beg))
              ;; new entry
              ;; update line number
              (incf cur-line-no (count-lines prev-pt line-beg))
              (setq prev-pt line-beg)
              (puthash line-beg
                       (list 1 cur-line-no (buffer-substring line-beg line-end) word-pos)
                       found-match-lines))
            (goto-char line-end)
            ))))
    ))

(defun occur-multi-sort (match-lines)
  ;; h is as returned by occur-multi-strs-engine
  ;; sort by decreasing number of occurrence
  (let (res)
    (maphash (lambda (k v) (push (cons k v) res)) match-lines)
    (sort res (lambda (x y)
                ;; cadr is now the occurrence-count
                (< (cadr y) (cadr x))))))

(defun occur-multi-str-output (sorted-match-lines regexps ori-buf out-buf)
  ;; each entry in sorted-match-lines is (line-beg occurrence-count line-no "matched-line" (word-beg . word-end) ...)
  (with-current-buffer out-buf
    ;; make-marker
    ;; set-marker
    (occur-mode)
    (let ((inhibit-read-only t)) ;; to allow modifying the buffer
      (erase-buffer)
      (let ((n-matches (length sorted-match-lines)))
        ;; title
        (insert (propertize
                 (format "%d matched line%s for %S in buffer: %s\n"
                         n-matches (if (<= n-matches 1) "" "s")
                         regexps (buffer-name ori-buf))
                 'read-only t))
        (add-face-text-property (point-min) (point) list-matching-lines-buffer-name-face)
        ;; list-matching-lines-face
        ;; each matched line
        (dolist (m sorted-match-lines)
          (let* ((match-str (fourth m))
                 (line-beg (first m))
                 ;; the list of (word-beg . word-end)
                 (occs (cddddr m))
                 ;; jump to the first occurrence in the line
                 (marker (set-marker (make-marker)
                                     (reduce 'min occs :key 'car)
                                     ori-buf)))
            ;; prefix
            (insert (propertize
                     (format "%7d:" (third m))
                     'font-lock-face list-matching-lines-prefix-face
                     'occur-prefix t
                     'mouse-face (list 'highlight)
                     'front-sticky t
                     'rear-nonsticky t
                     'occur-target marker
                     'follow-link t
                     'help-echo "mouse-2: go to this occurrence"))
          ;; matched str
            (dolist (occ occs)
              (let ((word-s (- (car occ) line-beg))
                    (word-e (- (cdr occ) line-beg)))
                (add-text-properties
                 word-s word-e
                 '(occur-match t) match-str)
                (add-face-text-property
                 word-s word-e
                 list-matching-lines-face nil match-str)))
            (insert (propertize
                     match-str
                     'mouse-face (list 'highlight)
                     'occur-target marker
                     'follow-link t
                     'help-echo "mouse-2: go to this occurrence")))
          (insert "\n")
          )))
      (goto-char (point-min))))

(defun occur-multi-strings (regexps)
  (interactive "MRegexps: ")
  (let* ((ori-buf-name (buffer-name))
         (rs (mapcar (lambda (x)
                       (cond ((stringp x) x)
                             ((symbolp x) (symbol-name x))
                             (t (prin1-to-string x))))
                     ;; use this hack to get a list of things
                     (car (read-from-string (concat "( " regexps " )")))))
         (matches (occur-multi-sort (occur-multi-strs-engine rs)))
         (n-matches (length matches))
         (out-buf-name "*Occur Multi-Str*")
         (out-buf (progn
                    (when (string= out-buf-name ori-buf-name)
                      ;; same as the searched buffer, rename it
                      (rename-uniquely))
                    (get-buffer-create out-buf-name))))
    ;;
    (message "Found %s matched line%s"
             n-matches (if (<= n-matches 1) "" "s"))
    (occur-multi-str-output matches rs (current-buffer) out-buf)
    (display-buffer out-buf)
    ;; add-text-properties: (occur-match)
    ;; buffer-substring to get the substring with the original text properties
    ;; prefix for line number
    ;; propertize for mouse click, marker to the original occurrence line
    ;; insert into out buffer, using occur-mode
    ))

(global-set-key (kbd "M-s s") 'occur-multi-strings)
;;
(defvar search-howto-path "~/Documents/personal/learning_notes/learning.org"
  "The path to the howto file that should be searched.")

(defun search-howto (regexps)
  (interactive "MRegexps: ")
  (with-current-buffer (find-file-noselect search-howto-path)
    (occur-multi-strings regexps)))

(global-set-key (kbd "M-s h") 'search-howto)
;;

;;;; evil
(use-package evil
  :ensure t
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-e") nil)
  (define-key evil-insert-state-map (kbd "C-y") nil)
  (define-key evil-insert-state-map (kbd "TAB") nil)
  (define-key evil-insert-state-map (kbd "C-a") nil)
  (define-key evil-insert-state-map (kbd "C-k") nil)
  (define-key evil-motion-state-map (kbd "C-e") nil)
  (define-key evil-motion-state-map (kbd "C-y") nil)
  (define-key evil-motion-state-map (kbd "TAB") nil)
  (use-package evil-surround
    :ensure t
    :config
    (global-evil-surround-mode 1))
  (use-package org-evil
    :ensure t)
  )

(use-package linum-relative
  :ensure t
  :config
  (linum-relative-global-mode 1)
  ;; Use `display-line-number-mode` as linum-mode's backend for smooth performance
  (setq linum-relative-backend 'display-line-numbers-mode)
  (setq linum-relative-current-symbol "->"))

(use-package key-chord
  :ensure t
  :config
  (setq key-chord-two-keys-delay 0.5)
  (key-chord-define evil-insert-state-map "kj" 'evil-normal-state)
  (key-chord-mode 1))
;;
(require 'dired)
(define-key dired-mode-map (kbd "C-c t") 'dired-hide-details-mode)

;;;; dired related, adapted from https://gitlab.com/protesilaos/dotemacs/-/blob/master/emacs-init.org
(use-package dired
  :ensure nil
  :custom
  (dired-recursive-copies 'always)
  ;;(dired-recursive-deletes 'always)
  (dired-isearch-filenames 'dwim)
  (delete-by-moving-to-trash t)
  (dired-listing-switches "-aAFhlv")
  (dired-dwim-target t)
  :hook
  (dired-mode . dired-hide-details-mode)
  (dired-mode . hl-line-mode)
  )

(use-package dired-subtree
  :ensure t
  :after dired
  :custom
  (dired-subtree-use-backgrounds nil)
  :bind (:map dired-mode-map
              ("<tab>" . dired-subtree-toggle)
              ("<C-tab>" . dired-subtree-cycle)
              ("<S-iso-lefttab>" . dired-subtree-remove)))

;;
(use-package autopair
  :ensure t
  :config
  (autopair-global-mode)
  )
