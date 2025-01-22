;; workaround black hyphens https://github.com/doomemacs/doomemacs/issues/8250

(custom-set-faces
 '(org-indent ((t (:foreground "gray")))))

;; latex preview
;; TODO: only on big monitors

(setq custom/latex-preview-scale 3)
(setq org-format-latex-options (plist-put org-format-latex-options :scale custom/latex-preview-scale))
