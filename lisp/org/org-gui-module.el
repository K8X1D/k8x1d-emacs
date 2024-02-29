;; General
(use-package org
  :hook ((org-mode . org-indent-mode)
	 (org-mode . visual-line-mode)))


;; Modern look
(use-package org-modern
  :hook ((org-mode . org-modern-mode)
         (org-agenda-finalize . org-modern-agenda))
  :config
  (setq org-modern-table t)

  ;; Edit settings
  (setq org-fold-catch-invisible-edits 'show-and-error)
  (setq org-special-ctrl-a/e t)
  (setq org-insert-heading-respect-content t)

  ;; Org styling, hide markup etc.
  (setq org-pretty-entities nil)
  (setq org-ellipsis "…")

  ;; Agenda styling
  (setq org-agenda-block-separator ?─)
  (setq org-agenda-time-grid
        '((daily today require-timed)
          (800 1000 1200 1400 1600 1800 2000)
          " ┄┄┄┄┄ " "┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄"))
  (setq org-agenda-current-time-string "⭠ now ─────────────────────────────────────────────────")

  ;; Bullets cutomization
  (setq org-modern-checkbox '((88 . "󰄲 ")
                              (45 . "󱋬 ")
                              (32 . "󰄮 ")))
  (setq org-modern-list '((43 . "▶")
                          (45 . "◦")
                          (42 . "•")))
  (setq org-modern-star '("◉" "●" "○"))
  (setq org-modern-hide-stars 'leading)

  ;; org block
  (setq org-modern-block-name t)
  (setq org-modern-block-fringe t)
  )

;; Better indentation for org-modern
(use-package org-modern-indent
  :vc (:url "https://github.com/jdtsmith/org-modern-indent"
            :branch "main")
  :hook (org-modern-mode . org-modern-indent-mode))

;; Hide/Show markup
(use-package org-appear
  :hook ((org-mode . (lambda ()
                             (add-hook 'evil-insert-state-entry-hook
                                       #'org-appear-manual-start
                                       nil
                                       t)
                             (add-hook 'evil-insert-state-exit-hook
                                       #'org-appear-manual-stop
                                       nil
                                       t)))
  (org-mode . org-appear-mode))
  :config
  (setq org-hide-emphasis-markers t
        org-appear-trigger 'manual
        ;;org-appear-trigger 'always
        org-appear-autoentities t
        org-appear-autosubmarkers t
        org-appear-autokeywords t
        org-appear-inside-latex t
        org-appear-autoemphasis t
        org-appear-autolinks t)
  )


;; Automatic tags alignement
(use-package org
  :config
  ;; Tags
  (setq org-auto-align-tags nil)
  ;; Dynamic tags position adjustment, inspired from https://emacs.stackexchange.com/questions/10087/how-to-better-align-tags-in-org-mode-using-variable-width-font and https://orgmode.org/worg/org-hacks.html#orgheadline64
  (setq k8x1d/org-adjust-tags-column t)
  (when k8x1d/org-adjust-tags-column
    (defun get-right-alignment-position ()
      (- 2 (window-max-chars-per-line)))
    (defun org-realign-all-tags-now ()
      (set (make-local-variable 'org-tags-column)
           (get-right-alignment-position))
      (org-align-all-tags)
      (set-buffer-modified-p nil)
      )
    (defun k8x1d/org-adjust-tags-column-before-save ()
      "Tags need to be left-adjusted when saving."
      (set (make-local-variable 'org-tags-column)
           1)
      (org-align-all-tags)
      (set-buffer-modified-p nil)
      )
    (defun k8x1d/org-adjust-tags-column-after-save ()
      "Revert left-adjusted tag position done by before-save hook."
      (set (make-local-variable 'org-tags-column)
           (get-right-alignment-position))
      (org-align-all-tags)
      (set-buffer-modified-p nil)
      )

    (setq org-tags-column (get-right-alignment-position)) 

    (add-hook 'org-mode-hook #'org-realign-all-tags-now)
    (add-hook 'text-scale-mode-hook #'org-realign-all-tags-now)
    (add-hook 'before-save-hook #'k8x1d/org-adjust-tags-column-before-save)
    (add-hook 'after-save-hook #'k8x1d/org-adjust-tags-column-after-save)

    (defadvice org-refile (around org-refile-disable-adjust-tags)
      "Disable dynamically adjusting tags"
      (let ((k8x1d/org-adjust-tags-column nil))
        ad-do-it))
    (ad-activate 'org-refile)

    ) 
  )


(provide 'org-gui-module)
