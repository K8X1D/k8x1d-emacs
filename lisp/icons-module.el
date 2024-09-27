;; -*- lexical-binding: t -*-
(use-package nerd-icons-completion
  :diminish
  :hook (marginalia-mode . nerd-icons-completion-mode))

(use-package nerd-icons-dired
  :diminish
  :hook (dired-mode . nerd-icons-dired-mode))

(use-package nerd-icons-ibuffer
  :diminish
  :hook (ibuffer-mode . nerd-icons-ibuffer-mode))

(provide 'icons-module)
