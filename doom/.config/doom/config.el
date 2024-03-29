;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Fabian Weik"
      user-mail-address "fabian.weik@protonmail.com")

;;;; Theming

(setq doom-theme 'catppuccin
      display-line-numbers-type 'relative)

(add-to-list 'default-frame-alist
             '(alpha-background . 85))

;; Font with size set dynamically
(defun set-font ()
  (let ((font-size
         (cond ((= (display-pixel-height) 1080) 24) ;; Full HD
               ((= (display-pixel-height) 2160) 32) ;; 4K scaled (Xorg x1.5)
               ((= (display-pixel-height) 2048) 12) ;; 2K - figure out when needed
               ((= (display-pixel-height) 4096) 36))) ;; 4K
        (noto-mono-family "BitstromWera Nerd Font Mono"))
    (setq doom-font (font-spec :family noto-mono-family :size font-size)
          nerd-icons-font-family noto-mono-family)))

(add-hook 'after-make-frame-functions
          (lambda (frame)
            (select-frame frame)
            (set-font)))

;; Org
(setq org-directory "~/org/")

;;;; Keymaps
(map! :n "C-s" 'save-buffer
      :ni "ö n" '+vterm/toggle  ;; Maybe: more similar to tmux (terminal full screen)
      :ni "ö t" '+vterm/here)

;; Autocomplete
(after! company
  (progn
    ;; Key bindings
    (keymap-set company-active-map "C-j" 'company-select-next)
    (keymap-set company-active-map "C-k" 'company-select-previous)
    (keymap-set company-active-map "C-l" 'company-complete-selection)
    (keymap-set company-active-map "RET" nil)
    (keymap-set company-active-map "<return>" nil)
    (keymap-set company-active-map "<up>" nil)
    (keymap-set company-active-map "<down>" nil)))

(after! lsp-mode
  (map! :leader
        "c r n" 'lsp-rename))

;; Git
(map! :leader
      "g p" 'magit-push-current-to-upstream)

;; Backends
;;(setq company-backends '((company-capf company-dabbrev-code)))))

;; Rust inline hints
(lsp-inlay-hints-mode)
(setq lsp-inlay-hint-enable t
      lsp-rust-analyzer-display-chaining-hints t
      lsp-rust-analyzer-closing-brace-hints nil)

;; Disable popup of function signature in rust
(setq lsp-signature-auto-activate '(:on-trigger-char)) ;; TODO: disable :on-server-request only for rust
