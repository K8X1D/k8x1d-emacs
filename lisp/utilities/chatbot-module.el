

(use-package ellama
    :init
    ;; setup key bindings
    (setopt ellama-keymap-prefix "C-c e")
    (setopt ellama-ollama-binary "docker exec -it ollama ollama")
    (defun k8x1d/launch-ollama ()
      (interactive)
      (async-shell-command "docker start ollama")
      )
    )

;; Keybindings
(use-package ellama
  :if k8x1d/use-general-keybindings
  :general
  (k8x1d/leader-keys
   "c" '(:keymap ellama-command-map
		  :package ellama
		  :which-key "Chatbot")
   )
  )

(provide 'chatbot-module)
