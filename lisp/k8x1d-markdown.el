


(use-package markdown
  :general
  (k8x1d/local-leader-keys
    :keymaps 'markdown-mode-map
    "RET" '(markdown-do :which-key "Interact")
    "p" '(markdown-preview :which-key "Preview")
    "m" '(markdown-toggle-markup-hiding :which-key "Toggle markup")
    "i" '(:ignore t :which-key "Insert")
    "it" '(markdown-insert-gfm-checkbox t :which-key "Ticksbox")
    "ii" '(markdown-insert-list-item  :which-key "Item")
    "ib" '(markdown-blockquote-region :which-key "Block Quote region")
    "ic" '(markdown-insert-gfm-code-block :which-key "Code Block")
    "il" '(markdown-insert-link :which-key "Link")
    "ih" '(:ignore t :which-key "Header")
    "ih1" '(markdown-insert-header-atx-1 :which-key "Header")
    "ih2" '(markdown-insert-header-atx-2 :which-key "Header")
    "ih3" '(markdown-insert-header-atx-3 :which-key "Header")
    "ih4" '(markdown-insert-header-atx-4 :which-key "Header")
    "ih5" '(markdown-insert-header-atx-5 :which-key "Header")
    "ih6" '(markdown-insert-header-atx-6 :which-key "Header")
    ))

(provide 'k8x1d-markdown)
