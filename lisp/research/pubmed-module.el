(use-package pubmed
  :commands (pubmed-search pubmed-advanced-search)
  :config
  (require 'k8x1d-keys)
  (setq pubmed-api-key k8x1d-pub-med-api-key)
  )

(provide 'pubmed-module)
