;; -*- lexical-binding: t; -*-

(use-package simple
  :diminish
  :ensure nil
  :hook
  (org-mode . visual-line-mode)
  )


(use-package face-remap
  :diminish (buffer-face-mode visual-line-mode)
  :ensure nil
  :hook
  (org-mode . variable-pitch-mode)
  (org-mode . buffer-face-mode)
  )

(provide 'text-module)
