;;
;; file explorer
;;


;; General configurations
(use-package dired
  :config
  (setq dired-auto-revert-buffer t))



;; File explorer
(use-package dired-sidebar
  :bind (("C-c o e" . dired-sidebar-toggle-sidebar))
  :commands (dired-sidebar-toggle-sidebar)
  :init
  (add-hook 'dired-sidebar-mode-hook
            (lambda ()
              (unless (file-remote-p default-directory)
                (auto-revert-mode))))
  :config
  (push 'toggle-window-split dired-sidebar-toggle-hidden-commands)
  (push 'rotate-windows dired-sidebar-toggle-hidden-commands)

  (setq dired-sidebar-subtree-line-prefix "__")
  ;;(setq dired-sidebar-theme 'vscode)
  (setq dired-sidebar-use-term-integration t)
  (setq dired-sidebar-use-custom-font t))



;;;; Show git info in Emacs Dired
;; Cause problems...
;;(use-package dired-git-info
;;  :hook
;;  (dired-after-readin . dired-git-info-auto-enable)
;;  :config
;;  ;; Don't hide dired details when showing git status
;;  (setq dgi-auto-hide-details-p nil)
;;  )

;;

;;;; Improved version of the Emacs inbuilt package Dired
;;(use-package dirvish
;;  :init
;;  (dirvish-override-dired-mode)
;;  :custom
;;  (dirvish-quick-access-entries ; It's a custom option, `setq' won't work
;;   '(("h" "~/"                          "Home")
;;     ("d" "~/Downloads/"                "Downloads")
;;     ("m" "/mnt/"                       "Drives")))
;;  :config
;;  (dirvish-peek-mode) ; Preview files in minibuffer
;;  ;;(dirvish-side-follow-mode) ; similar to `treemacs-follow-mode'
;; ;; (setq dirvish-mode-line-format
;; ;;       '(:left (sort symlink) :right (omit yank index)))
;; ;; (setq dirvish-attributes
;; ;;       '(all-the-icons file-time file-size collapse subtree-state vc-state git-msg))
;; ;; (setq delete-by-moving-to-trash t)
;; ;; (setq dired-listing-switches
;; ;;       "-l --almost-all --human-readable --group-directories-first --no-group")
;; ;; :bind ; Bind `dirvish|dirvish-side|dirvish-dwim' as you see fit
;; ;; (("C-c f" . dirvish-fd)
;; ;;  :map dirvish-mode-map ; Dirvish inherits `dired-mode-map'
;; ;;  ("a"   . dirvish-quick-access)
;; ;;  ("f"   . dirvish-file-info-menu)
;; ;;  ("y"   . dirvish-yank-menu)
;; ;;  ("N"   . dirvish-narrow)
;; ;;  ("^"   . dirvish-history-last)
;; ;;  ("h"   . dirvish-history-jump) ; remapped `describe-mode'
;; ;;  ("s"   . dirvish-quicksort)    ; remapped `dired-sort-toggle-or-edit'
;; ;;  ("v"   . dirvish-vc-menu)      ; remapped `dired-view-file'
;; ;;  ("TAB" . dirvish-subtree-toggle)
;; ;;  ("M-f" . dirvish-history-go-forward)
;; ;;  ("M-b" . dirvish-history-go-backward)
;; ;;  ("M-l" . dirvish-ls-switches-menu)
;; ;;  ("M-m" . dirvish-mark-menu)
;; ;;  ("M-t" . dirvish-layout-toggle)
;; ;;  ("M-s" . dirvish-setup-menu)
;; ;;  ("M-e" . dirvish-emerge-menu)
;;  ;;  ("M-j" . dirvish-fd-jump)
;;  )





(provide 'k8x1d-file-explorer)
