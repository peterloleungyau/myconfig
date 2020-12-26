;; following https://nyxt.atlas.engineer/article/dark-theme.org
(define-configuration minibuffer
  ((style
    (str:concat
     %slot-default
     (cl-css:css
      '((body
         :background-color "#121212"
         :color "#808080")))))))

(define-configuration internal-buffer
  ((style
    (str:concat
     %slot-default
     (cl-css:css
      '((body
         :background-color "#121212"
         :color "lightgray")
        (hr
         :color "darkgray")
        (.button
         :color "#333333")))))))

(define-configuration window
  ((message-buffer-style
    (str:concat
     %slot-default
     (cl-css:css
      '((body
         :background-color "#121212"
         :color "lightgray")))))))

;; vimium like keybindings
(defvar *my-keymap* (make-keymap "my-map"))
(define-key *my-keymap*
    "j" 'nyxt/web-mode:scroll-down ;; scroll-down
    "k" 'nyxt/web-mode:scroll-up ;; scroll-up
    "g g" 'nyxt/web-mode:scroll-to-top ;; scroll to the top of the page
    "G" 'nyxt/web-mode:scroll-to-bottom ;; scroll to the bottom of the page
    "d" 'nyxt/web-mode:scroll-page-down ;; scroll a half page down
    "u" 'nyxt/web-mode:scroll-page-up ;; scroll a half page up
    "h" 'nyxt/web-mode:scroll-left ;; scroll left
    "l" 'nyxt/web-mode:scroll-right ;; scroll right
    "r" 'reload-current-buffer ;; reload the page
    "y y" 'copy-url ;; copy the current URL to the clipboard
    ;; "p"  ;; open the clipboard's URL in a new tab
    ;; "i" ;; enter insert mode
    ;; "v" ;; enter visual mode
    ;; "g i" ;; focus the first text input on the page
    "f" 'nyxt/web-mode:follow-hint ;; open a link in the current tab
    "F" 'nyxt/web-mode:follow-hint-new-buffer-focus ;; open a link in a new tab
    "/" 'nyxt/web-mode:search-buffer ;; enter find mode
    "H" 'nyxt/web-mode:history-backwards ;; go back in history
    "L" 'nyxt/web-mode:history-forwards ;; go forward in history
    "t" 'make-buffer-focus ;; create new tab
    "J" 'switch-buffer-previous ;; go one tab left
    "K" 'switch-buffer-next ;; go one tab right
    "x" 'delete-buffer ;; close current tab
    "X" 'reopen-last-buffer ;; re-open last closed tab
    ;; "C-f" 'nyxt/web-mode:history-forwards
    ;; "C-b" 'nyxt/web-mode:history-backwards
    )

(define-mode my-mode ()
  "Dummy mode for the custom key bindings in `*my-keymap*'."
  ((keymap-scheme (keymap:make-scheme
                   scheme:cua *my-keymap*
                   scheme:emacs *my-keymap*
                   scheme:vi-normal *my-keymap*))))

(define-configuration (buffer web-buffer)
  ((default-modes (append '(my-mode) %slot-default))))
