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
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ;; for temporary problem with elpa using https
                         ;;("gnu-mirror" . "http://mirrors.163.com/elpa/gnu/")
                         ("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")))

(when (>= emacs-major-version 25)
  (setq package-archive-priorities '(("org" . 4)
                                     ("melpa" . 3)
                                     ("gnu-mirror" . 2)
                                     ;;("gnu" . 1)
                                     )))
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
;;(setq load-path (append (cjp-get-dir-structure-in "lisp") load-path))

;;;;;;
;;; legacy settings
(require 'cl)

;;;;;;

;;;;;;
(setq sh-indent-comment t
      sh-basic-offset 2)

(setq vc-follow-symlinks t)
;;;;;;
;;; for quick lookup of man page and hyperspec
(global-set-key  [f6] (lambda () (interactive) (manual-entry (current-word))))

(global-set-key  [f7] 'common-lisp-hyperspec)
(setq common-lisp-hyperspec-root "file:/usr/share/doc/hyperspec/")
;;;;;;
;;; compilation
;;(global-set-key (kbd "C-c c") 'compile)

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
(setq exec-path (cons "/home/peter/.guix-profile/bin" exec-path))
(setenv "PATH" (concat "/home/peter/.guix-profile/bin:" (getenv "PATH")))

(use-package ess
  :ensure t
  :init (require 'ess-site)
  (setq ess-fancy-comments nil))

;; copied and modified from
;;  https://emacs.stackexchange.com/questions/8041/how-to-implement-the-piping-operator-in-ess-mode
(defun then-R-operator ()
  "R - %>% operator or 'then' pipe operator"
  (interactive)
  (just-one-space 1)
  (insert "%>% "))
(define-key ess-mode-map (kbd "M-M") 'then-R-operator)
(define-key inferior-ess-mode-map (kbd "M-M") 'then-R-operator)

(defun my-R-assign ()
  "R - <- operator"
  (interactive)
  (just-one-space 1)
  (insert "<- "))
(define-key ess-r-mode-map (kbd "M--") #'my-R-assign)
(define-key inferior-ess-r-mode-map (kbd "M--") #'my-R-assign)
;;;;;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#0a0814" "#f2241f" "#67b11d" "#b1951d" "#4f97d7" "#a31db1" "#28def0" "#b2b2b2"])
 '(column-number-mode t)
 '(custom-enabled-themes (quote (spacemacs-dark)))
 '(custom-safe-themes
   (quote
    ("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default)))
 '(display-line-numbers-type (quote relative))
 '(electric-indent-mode nil)
 '(ess-indent-with-fancy-comments nil)
 '(ess-own-style-list
   (quote
    ((ess-indent-offset . 2)
     (ess-offset-arguments . open-delim)
     (ess-offset-arguments-newline . prev-call)
     (ess-offset-block . prev-line)
     (ess-offset-continued . straight)
     (ess-align-nested-calls "ifelse")
     (ess-align-arguments-in-calls "function[ 	]*(")
     (ess-align-continuations-in-calls . t)
     (ess-align-blocks control-flow)
     (ess-indent-from-lhs arguments fun-decl-opening)
     (ess-indent-from-chain-start . t)
     (ess-indent-with-fancy-comments . t))))
 '(ess-style (quote RStudio))
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
    (ripgrep ag window-numbering pdf-tools highlight-indent-guides debbugs yaml-mode yaml-model ewal-spacemacs-themes nix-mode key-chord org-evil autopair linum-relative dired-subtree dired evil-surround evil evil-mode pydoc-info elpy yasnippet-snippets yasnippet lsp-python ess-R-data-view ess-smart-equals ess-smart-underscore ess-view company-lsp lsp-ui lsp-mode counsel-projectile projectile counsel ivy org-plus-contrib org-link-minor-mode ox-hugo ob-ipython ob-mongo ob-prolog ob-sagemath ob-sql-mode spacemacs-theme magit slime org-ref markdown-mode ess auctex)))
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
(setq org-blank-before-new-entry '((heading . never) (plain-list-item . never)))

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
   ;;(sh . t)
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

(setq org-capture-templates
      '(("t" "Todo [inbox]" entry
         (file+headline "~/todo.org" "Tasks")
         "* TODO %i%?")
        ("h" "Howto" entry
         (file+headline "~/projects/learning_notes/learning.org" "HowTo")
         "* %i%?")
        ))

(global-set-key (kbd "C-c c") 'org-capture)
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
(use-package projectile
  :ensure t
  :bind-keymap ("\C-c p" . projectile-command-map)
  :config
  (projectile-mode +1)
  ;;(setq projectile-completion-system 'ivy)
  ;;(use-package counsel-projectile
  ;;  :ensure t)
  (use-package ag
    :ensure t)
  (use-package ripgrep
    :ensure t)
  )
(setq projectile-project-search-path '("~/projects/" "~/old_home/research/"))

(use-package yasnippet
  :ensure t
  :init
  (yas-global-mode 1)
  :config
  (use-package yasnippet-snippets
    :ensure t)
  (add-to-list 'yas-snippet-dirs (locate-user-emacs-file "snippets"))
  (add-to-list 'yas-snippet-dirs "/home/peter/myconfig/snippets/")
  (yas-reload-all)
  )

(use-package lsp-mode
  ;; :hook (python-mode . lsp)
  :commands lsp)

(use-package lsp-ui :commands lsp-ui-mode)
(use-package company-lsp :commands company-lsp)

;;
(defun block-line-end ()
  "To get the end of Python block of current indentation.
From https://stackoverflow.com/questions/27777133/change-the-emacs-send-code-to-interpreter-c-c-c-r-command-in-ipython-mode
"
  (setq indentation (current-indentation))
  (forward-line)
  (while (> (current-indentation) indentation)
    (forward-line))
  (forward-line -1)
  (line-end-position))

(defun my-python-shell-send-region (&optional beg end)
  "To automatically send a code block.
From https://stackoverflow.com/questions/27777133/change-the-emacs-send-code-to-interpreter-c-c-c-r-command-in-ipython-mode
"
  (interactive)
  (let ((beg (cond (beg beg)
                   ((region-active-p) (region-beginning))
                   (t (line-beginning-position))))
        (end (cond (end end)
                   ((region-active-p) 
                    (copy-marker (region-end)))
                   (t (block-line-end)))))
    (python-shell-send-region beg end))
  (forward-line))

(use-package elpy
  :ensure t
  :commands elpy-enable
  :init (with-eval-after-load 'python (elpy-enable))
  :config
  (flymake-mode -1)
  :bind (:map python-mode-map
              ("<C-return>" . my-python-shell-send-region))
  )
;;;;;;
(use-package auctex
  :ensure t
  :defer t
  )

;;;;;;
(require 'info-look)

(info-lookup-add-help
 :mode 'python-mode
 :regexp "[[:alnum:]_]+"
 :doc-spec
 '(("(python)Index" nil "")))

;;;;;
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

(defvar occur-regexp-abbr
  '()
  "Association list of regexp abbreviation as (abbr . substitution), where the abbr string would be replaced by the substitution in regexps. E.g. ((\"r\" . \"\\\\bR\\\\\") ...) would match 'R' as a word just by using the abbreviation 'r'.")

(defun occur-multi-strings (regexps)
  (interactive "MRegexps: ")
  (let* ((ori-buf-name (buffer-name))
         (rs-raw (mapcar (lambda (x)
                           (cond ((stringp x) x)
                                 ((symbolp x) (symbol-name x))
                                 (t (prin1-to-string x))))
                         ;; use this hack to get a list of things
                         (car (read-from-string (concat "( " regexps " )")))))
         ;; regexp substitution of abbreviation
         (rs (mapcar (lambda (r)
                             (or (cdr (assoc r occur-regexp-abbr))
                                 r))
                           rs-raw))
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
(defvar search-howto-path "~/projects/learning_notes/learning.org"
  "The path to the howto file that should be searched.")

(defvar search-bookmarks-path "~/projects/learning_notes/bookmarks.org"
  "The path to the bookmarks file that should be searched.")

(defvar search-howto-regexp-abbr
  '(("r" . "\\bR\\b")
    ("os" . "\\bOS\\b"))
  "Would be used as `occur-regexp-abbr' in using search-howto, see `occur-regexp-abbr' for the documentation.")

(defun search-howto (regexps)
  (interactive "MRegexps: ")
  (with-current-buffer (find-file-noselect search-howto-path)
    (let ((occur-regexp-abbr search-howto-regexp-abbr))
      (occur-multi-strings regexps))))

(defun search-bookmarks (regexps)
  (interactive "MRegexps: ")
  (with-current-buffer (find-file-noselect search-bookmarks-path)
    (let ((occur-regexp-abbr search-howto-regexp-abbr))
      (occur-multi-strings regexps))))

(global-set-key (kbd "M-s h") 'search-howto)
(global-set-key (kbd "M-s m") 'search-bookmarks)

;;;; ido-mode
(setq ido-enable-flex-matching t)
(setq ido-create-new-buffer 'always)
(setq ido-everywhere nil)
(ido-mode 1)
(ido-everywhere 0)
(setq ido-auto-merge-work-directories-length -1)

;;;; evil
(add-hook 'undo-tree-mode-hook
          (lambda ()
            (define-key undo-tree-map (kbd "C-r") nil)
            (define-key undo-tree-map (kbd "C-z") 'undo-tree-undo)
            (define-key undo-tree-map (kbd "C-S-z") 'undo-tree-redo)
            (global-set-key (kbd "C-r") 'isearch-backward)
            ))

(use-package evil
  :ensure t
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-e") nil)
  (define-key evil-insert-state-map (kbd "C-y") nil)
  (define-key evil-insert-state-map (kbd "TAB") nil)
  (define-key evil-insert-state-map (kbd "C-a") nil)
  (define-key evil-insert-state-map (kbd "C-k") nil)
  (define-key evil-insert-state-map (kbd "C-w") nil)
  (define-key evil-insert-state-map (kbd "C-r") nil)
  (define-key evil-motion-state-map (kbd "C-e") nil)
  (define-key evil-motion-state-map (kbd "C-y") nil)
  (define-key evil-motion-state-map (kbd "TAB") nil)
  (define-key evil-motion-state-map (kbd "C-w") nil)
  (define-key evil-motion-state-map (kbd "C-r") nil)
  (define-key evil-normal-state-map (kbd "C-r") nil)
  (undo-tree-mode 1)
  (define-key undo-tree-map (kbd "C-r") nil)
  (evil-set-initial-state 'debbugs-gnu-mode 'emacs)
  
  (use-package evil-surround
    :ensure t
    :config
    (global-evil-surround-mode 1))
  (use-package org-evil
    :ensure t)
  )

(global-set-key (kbd "C-r") 'isearch-backward)

(use-package linum-relative
  :ensure t
  :config
  (linum-relative-global-mode 1)
  ;; Use `display-line-number-mode` as linum-mode's backend for smooth performance
  (setq linum-relative-backend 'display-line-numbers-mode))

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
  (dired-listing-switches "-aAFhlv --group-directories-first")
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

;;
(use-package nix-mode
  :mode "\\.nix\\'")

;; simple list item manipulation based on indentation, e.g. in yaml
(defvar simple-indent-list-offset 2
  "The number of spaces for each indentation.")

(defun simple-indent-list-goto (wanted-indent n skip)
  "Move by N items while skipping some lines.
If N is positive, move forward, otherwise move backward. Blank lines and those lines where `(skip line-indent wanted-indent)' is true are skipped an not counted toward N. Go to at most N lines which are not blank and where `(skip line-indent wanted-indent)' is false. Stop and return nil if beginning of buffer or end of buffer is reached before N good lines are found. Otherwise returns t.
Adapted from https://emacs.stackexchange.com/a/27169"
  (let ((direction (if (> n 0) 1 -1))
        (n (abs n)))
    (while (and (> n 0)
                ;; forward-line returns 0 on success
                (zerop (forward-line direction))
                (or (eolp)
                    ;; skip over blank lines
                    (funcall skip (current-indentation) wanted-indent)
                    (decf n))))
    (= n 0)))

(defun simple-indent-list-next-item (&optional n)
  "Jump to the next N items with the same or less indentation.
N defaults to 1. If N is negative, would go backward, i.e. to previous N item.
Will go to the end of buffer if no such item exists."
  (interactive "p")
  (let ((cur-col (current-column)))
    (and (simple-indent-list-goto (current-indentation) (or n 1) '>)
         (move-to-column cur-col))))

(defun simple-indent-list-prev-item (&optional n)
  "Jump to the previous item with the same or less indentation.
N defaults to 1. If N is negative, would go forward, i.e. to next N item.
Will go to the beginning of buffer if no such item exists."
  (interactive "p")
  (simple-indent-list-next-item (if (null n) -1 (- n))))

(defun simple-indent-list-parent-item (&optional n)
  "Jump to the N previous item with strictly less indentation.
Will go to the beginning of buffer if no such item exists."
  (interactive "p")
  (let ((cur-col (current-column)))
    (setq n (or n 1))
    (and (simple-indent-list-goto (current-indentation) (- n) '>=)
         (move-to-column cur-col))))

(defun simple-indent-list-select-item (&optional n)
  "Select the region of the whole subtree(s) of N items.
N defaults to 1. If N is negative, select N previous items instead."
  (interactive "p")
  (beginning-of-line)
  (set-mark-command nil)
  (simple-indent-list-goto (current-indentation) (or n 1) '>))

(defun simple-indent-list-act-item (action n)
  "Call (action beg end) on the region of the whole subtree(s) of N items.
If N is negative, kill N previous items instead."
  (beginning-of-line)
  (let ((beg (point)))
    (simple-indent-list-goto (current-indentation) (or n 1) '>)
    (funcall action beg (point))))

(defun simple-indent-list-kill-item (&optional n)
  "Kill the region of the whole subtree(s) of N items.
N defaults to 1. If N is negative, kill N previous items instead."
  (interactive "p")
  (simple-indent-list-act-item 'kill-region (or n 1)))

(defun simple-indent-list-copy-item (&optional n)
  "Copy the region of the whole subtree(s) of N items, as in kill-ring-save.
N defaults to 1. If N is negative, kill N previous items instead."
  (interactive "p")
  (save-excursion
    (simple-indent-list-act-item 'kill-ring-save n)))

(defun simple-indent-list-yank-item ()
  "Paste the region of the whole subtree(s) previously killed.
Will make sure there is a newline at the end of the pasted region and the current line."
  (interactive)
  (beginning-of-line)
  (yank)
  (unless (equalp (point) (line-beginning-position))
    (insert "\n")))

(defun simple-indent-list-move-item-down (&optional n)
  "Move the whole subtree of the current item down N items.
N defaults to 1. If N is negative, would move up N items instead."
  (interactive "p")
  (let ((cur-indent (current-indentation))
        (cur-col (current-column))
        (cur-item (simple-indent-list-act-item 'delete-and-extract-region 1)))
    (simple-indent-list-goto cur-indent (or n 1) '>)
    (save-excursion
      (beginning-of-line)
      (insert cur-item)
      (unless (equalp (point) (line-beginning-position))
        (insert "\n")))
    (move-to-column cur-col)))

(defun simple-indent-list-move-item-up (&optional n)
  "Move the whole subtree of the current item up N items.
If N is negative, would move down N items instead."
  (interactive "p")
  (simple-indent-list-move-item-down (if (null n) -1 (- n))))

(defun simple-indent-list-move-item-indent (&optional n)
  "Indent the whole subtree of the current item, i.e. move it to the right by N steps.
Each step consists of `simple-indent-list-offset' spaces. N defaults to 1. If N is negative, would move to the left instead."
  (interactive "p")
  (let ((indent-adjust (max (* simple-indent-list-offset (or n 1))
                            (- (current-indentation)))))
    (unless (zerop indent-adjust)
      ;; do not let the line go past the left edge, which may destroy the structure
      (save-excursion
        (beginning-of-line)
        (let ((beg (point)))
          (simple-indent-list-goto (current-indentation) 1 '>)
          (unless (eobp)
            ;; unless at end of buffer, it overshoots one line
            (backward-char 1))
          (indent-rigidly beg (point) indent-adjust)
          )))))

(defun simple-indent-list-move-item-outdent (&optional n)
  "Outdent the whole subtree of the current item, i.e. move it to the left by N steps.
Each step consists of `simple-indent-list-offset' spaces. N defaults to 1. If N is negative, would move to the right instead."
  (interactive "p")
  (simple-indent-list-move-item-indent (if (null n) -1 (- n))))

(defun simple-indent-list-line-indent (&optional n)
  "Indent the current line, i.e. move it to the right by N steps.
Each step consists of `simple-indent-list-offset' spaces. N defaults to 1. If N is negative, would move to the left instead."
  (interactive "p")
  (let ((indent-adjust (max (* simple-indent-list-offset (or n 1))
                            (- (current-indentation)))))
    (unless (zerop indent-adjust)
      (save-excursion
        (indent-rigidly (line-beginning-position) (line-end-position) indent-adjust)))))

(defun simple-indent-list-line-outdent (&optional n)
  "Indent the current line, i.e. move it to the left by N steps.
Each step consists of `simple-indent-list-offset' spaces. N defaults to 1. If N is negative, would move to the right instead."
  (interactive "p")
  (simple-indent-list-line-indent (if (null n) -1 (- n))))

;;; from https://stackoverflow.com/a/4459159
(defun aj-toggle-fold ()
  "Toggle fold all lines larger than indentation on current line"
  (interactive)
  (let ((col 1))
    (save-excursion
      (back-to-indentation)
      (setq col (+ 1 (current-column)))
      (set-selective-display
       (if selective-display nil (or col 1))))))

(use-package yaml-mode
  :ensure t
  :bind (:map yaml-mode-map
              ("<C-tab>" . aj-toggle-fold)
              ("<C-M-up>" . simple-indent-list-prev-item)
              ("<C-M-down>" . simple-indent-list-next-item)
              ("C-M-u" . simple-indent-list-parent-item)
              ("C-c r" . simple-indent-list-select-item)
              ("C-c k" . simple-indent-list-kill-item)
              ("C-c w" . simple-indent-list-copy-item)
              ("C-c y" . simple-indent-list-yank-item)
              ("<M-left>" . simple-indent-list-line-outdent)
              ("<M-right>" . simple-indent-list-line-indent)
              ("<M-S-left>" . simple-indent-list-move-item-outdent)
              ("<M-S-right>" . simple-indent-list-move-item-indent)
              ("<M-up>" . simple-indent-list-move-item-up)
              ("<M-down>" . simple-indent-list-move-item-down))
  )

(use-package debbugs
  :ensure t)

;;

(use-package highlight-indent-guides
  :ensure t
  :init
  (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
  (add-hook 'yaml-mode-hook 'highlight-indent-guides-mode)
  (setq highlight-indent-guides-method 'column)
  )

;;
(use-package pdf-tools
  :ensure t
  :config
  (pdf-tools-install))

;;;;;;
(use-package window-numbering
    :ensure t
    :config
    (window-numbering-mode))

;;;;;;
(add-hook 'pdf-view-mode-hook (lambda () (linum-relative-mode -1)))
 
;;;;;;
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "DejaVu Sans Mono" :foundry "unknown" :slant normal :weight normal :height 158 :width normal)))))
