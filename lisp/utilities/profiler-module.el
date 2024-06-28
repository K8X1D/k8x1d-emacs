

;; Keybindings
(use-package emacs
  :if k8x1d/use-general-keybindings
  :general
  (k8x1d/leader-keys
   "P" '(:ignore t :which-key "Profiler")
   "Ps" '(profiler-start :which-key "Profiler")
   "Pe" '(profiler-stop :which-key "Profiler")
   "Pr" '(profiler-report :which-key "Profiler")
   )
  )




(provide 'profiler-module)
