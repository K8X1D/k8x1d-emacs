;; -*- lexical-binding: t -*-

(use-package ellama
  :general
  (k8x1d/leader-keys
    "o" '(:ignore t :which-key "Open")
    "oc" '(:ignore t :which-key "Chatbot")
    "oca" '(ellama-ask-about :which-key "Ask")
    )
  :init
  ;; setup key bindings
  (setopt ellama-keymap-prefix "C-c e")
  (setopt ellama-ollama-binary "docker exec -it ollama ollama")
  (defun k8x1d/launch-ollama ()
    (interactive)
    (async-shell-command "docker start ollama")
    )
  )

(provide 'chatbot-module)
