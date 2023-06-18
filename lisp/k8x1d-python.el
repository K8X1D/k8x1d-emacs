(use-package python-mode
  :bind (:map python-mode-map
         ("C-c C-z" . run-python))
  :hook (python-mode . eglot-ensure))




(provide 'k8x1d-python)
