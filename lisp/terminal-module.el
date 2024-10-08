;; -*- lexical-binding: t; -*-


(use-package shell
  :if (string= k8x1d/terminal "shell")
  :ensure nil
  :general
  (k8x1d/leader-keys
   "o"  '(:ignore t :which-key "Open")
   "ot"  '(shell :which-key "Terminal (Dedicated)")
    )
  )


(use-package vterm
  :if (string= k8x1d/terminal "vterm")
  :init
  (setenv "CC" "gcc")
  :config
  (setq vterm-max-scrollback 10000))

(use-package multi-vterm
  :if (string= k8x1d/terminal "vterm")
  :general
  (k8x1d/leader-keys
   "o"  '(:ignore t :which-key "Open")
   "ot"  '(multi-vterm-dedicated-toggle :which-key "Terminal (Dedicated)")
    )
  :init
  (defun k8x1d/multi-vterm-project-vertical ()
    (interactive)
    (require 'multi-vterm)
    (multi-vterm-project)
    (evil-window-move-very-bottom)
    (evil-window-set-height 16)
    )
  :bind (("C-c o t" .  multi-vterm-dedicated-toggle)
 	 (:map project-prefix-map
 	       ("t" . k8x1d/multi-vterm-project-vertical)))
  :config
  (setq multi-vterm-dedicated-window-height 17)
  (add-to-list 'project-switch-commands '(k8x1d/multi-vterm-project-vertical "Terminal" "t"))
  )

(provide 'terminal-module)
