(use-package emacs
  :hook (after-init . pixel-scroll-precision-mode)
  :config
  (setq scroll-conservatively 10000)
  (setq inhibit-compacting-font-caches t)
  )

(provide 'scrolling-module)
