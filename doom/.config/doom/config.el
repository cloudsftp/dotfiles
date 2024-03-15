;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Fabian Weik"
      user-mail-address "fabian.weik@protonmail.com")

;;;; Theming

;; Font
(setq noto-mono-family "NotoSansM Nerd Font Mono"
      font-size 24
      doom-font (font-spec :family noto-mono-family :size font-size)
      nerd-icons-font-family noto-mono-family)

(setq doom-theme 'catppuccin
      display-line-numbers-type 'relative)

(add-to-list 'default-frame-alist
             '(alpha-background . 80))

;; Org
(setq org-directory "~/org/")

;; Keymaps
(map! :n "C-s" 'save-buffer)

(after! company
  (progn
    (keymap-set company-active-map "RET" nil) ;; Not working???
    (keymap-set company-active-map "C-j" 'company-select-next)
    (keymap-set company-active-map "C-k" 'company-select-previous)
    (keymap-set company-active-map "C-l" 'company-complete-selection)))

;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
