;; latex preview
;; TODO: only on big monitors

(setq custom/latex-preview-scale 2.5)
(setq org-format-latex-options (plist-put org-format-latex-options :scale custom/latex-preview-scale))
