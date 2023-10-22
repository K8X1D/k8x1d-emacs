;;; package --- Summary

;;; Commentary:

;;; Code:

;; File-explorer
(use-package dired
  :if (equal file-explorer "dired")
  :ensure nil
  :config
  (setq dired-auto-revert-buffer t)
  )

;; Icons support
(use-package nerd-icons-dired
  :if (equal file-explorer "dired")
  :hook
  (dired-mode . nerd-icons-dired-mode))

;;

;; Improved version of the Emacs inbuilt package Dired

(use-package dirvish
  :if (equal file-explorer "dirvish")
  :hook ((after-init . dirvish-override-dired-mode)
	 (dirvish-override-dired-mode . dirvish-peek-mode)) ;; Preview files in minibuffer
  :custom
  (dirvish-quick-access-entries ; It's a custom option, `setq' won't work
   '(("h" "~/"                          "Home")
     ("d" "~/Downloads/"                "Downloads")
     ("m" "/mnt/"                       "Drives")))
  :config
  (setq dirvish-preview-dispatchers '(image gif video audio epub pdf archive))
  ;; faster pdf preview
  (setq dirvish-preview-dispatchers
	(cl-substitute 'pdf-preface 'pdf dirvish-preview-dispatchers))
  ;; Cache
  (setq dirvish-cache-dir (concat user-emacs-cache-directory "/dirvish/")) 

  ;; Modeline | header line
  (setq dirvish-use-header-line nil)     ; hide header line (show the classic dired header)
  (setq dirvish-use-mode-line nil)       ; hide mode line

  ;; Nerd icon support
  (setq dirvish-attributes
	'(vc-state subtree-state nerd-icons collapse git-msg file-time file-size))
  (setq dirvish-subtree-state-style 'nerd)

  ;; Ensure tab is free
  ;; see https://github.com/alexluigit/dirvish/issues/188
  ;; FIXME: readjust 
  ;; (evil-make-overriding-map dirvish-mode-map 'normal)

  ;; 
  (setq dired-listing-switches
        "-l --almost-all --human-readable --group-directories-first --no-group")
  :bind ; Bind `dirvish|dirvish-side|dirvish-dwim' as you see fit
  (("C-x d" . dirvish)
   :map dirvish-mode-map ; Dirvish inherits `dired-mode-map'
   ("q"   . dirvish-quit)
   ("a"   . dirvish-quick-access)
   ("f"   . dirvish-file-info-menu)
   ("y"   . dirvish-yank-menu)
   ("N"   . dirvish-narrow)
   ("^"   . dirvish-history-last)
   ("h"   . dirvish-history-jump) ; remapped `describe-mode'
   ("s"   . dirvish-quicksort)    ; remapped `dired-sort-toggle-or-edit'
   ("v"   . dirvish-vc-menu)      ; remapped `dired-view-file'
   ("TAB" . dirvish-subtree-toggle)
   ("M-f" . dirvish-history-go-forward)
   ("M-b" . dirvish-history-go-backward)
   ("M-l" . dirvish-ls-switches-menu)
   ("M-m" . dirvish-mark-menu)
   ("M-t" . dirvish-layout-toggle)
   ("M-s" . dirvish-setup-menu)
   ("M-e" . dirvish-emerge-menu)
   ("M-j" . dirvish-fd-jump))
  )


(provide 'file-explorer-module)
;;; file-explorer-module.el ends here
