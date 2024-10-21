;; -*- lexical-binding: t; -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;; Flymake ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package flymake
  :if (string= k8x1d/checker "flymake")
  :diminish
  :general
  (k8x1d/local-leader-keys
    :keymaps 'flymake-mode-map
    "c" '(:ignore t :which-key "Checker")
    "cl" '(flymake-show-buffer-diagnostics :which-key "List")
    "cn" '(flymake-goto-prev-error :which-key "Prev")
    "cp" '(flymake-goto-next-error :which-key "Next")
    )
  :bind (:map flymake-mode-map
	      ("C-c d p" . flymake-goto-prev-error)
	      ("C-c d n" . flymake-goto-next-error)
	      ("C-c d l" . flymake-show-buffer-diagnostics)
	      )
  )
(use-package flymake-collection
  :if (string= k8x1d/checker "flymake")
  :hook (flymake-mode . flymake-collection-hook-setup)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;; Flycheck ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package flycheck
  :if (string= k8x1d/checker "flycheck")
  :general
  (k8x1d/local-leader-keys
    "c" '(:keymap flycheck-command-map
		  :package flycheck
		  :which-key "Checker")
    )
  :diminish
  :config
  (setq flycheck-checker-error-threshold 2500) 
  )

(provide 'checker-module)
