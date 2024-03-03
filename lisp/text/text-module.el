;; General
(use-package emacs
  :hook (text-mode . visual-line-mode))

;; Mixed fonts
(use-package mixed-pitch
  :hook ((text-mode . mixed-pitch-mode)
         (markdown-mode . mixed-pitch-mode)))

(provide 'text-module)
