;; General configuration
(use-package flymake
    :bind
    (("C-c ! n" . flymake-goto-next-error)
     ("C-c ! p" . flymake-goto-prev-error)
     ("C-c ! l" . flymake-show-buffer-diagnostics))
    )

;; Extended support
(use-package flymake-collection
  :hook (after-init . flymake-collection-hook-setup))


(provide 'checker-module)
