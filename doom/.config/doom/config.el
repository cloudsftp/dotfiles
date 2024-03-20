;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Fabian Weik"
      user-mail-address "fabian.weik@protonmail.com")

;;;; Theming

;; Font
(setq font-size
      (cond ((= (display-pixel-height) 1080) 24)
            ((= (display-pixel-height) 2048) 12) ;; Figure out when needed
            ((= (display-pixel-height) 4096) 32)))

(setq noto-mono-family "NotoSansM Nerd Font Mono"
      doom-font (font-spec :family noto-mono-family :size font-size)
      nerd-icons-font-family noto-mono-family)

(setq doom-theme 'catppuccin
      display-line-numbers-type 'relative)

(add-to-list 'default-frame-alist
             '(alpha-background . 85))

;; Org
(setq org-directory "~/org/")

;; Keymaps
(map! :n "C-s" 'save-buffer
      :ni "ö n" '+vterm/toggle  ;; Maybe: more similar to tmux (terminal full screen)
      :ni "ö t" '+vterm/here)

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

;; Backends
;;(setq company-backends '((company-capf company-dabbrev-code)))))
