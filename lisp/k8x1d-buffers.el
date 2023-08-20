;; Better buffer manager
(use-package emacs
  :general
  (k8x1d/leader-keys
    "b" '(:ignore t :which-key "Buffer")
    "bi" '(ibuffer :which-key "Ibuffer")
    ;;"bs" '(switch-to-buffer :which-key "Switch")
    "bs" '(consult-buffer :which-key "Switch")
    "bk" '(kill-buffer :which-key "Kill")
    "bp" '(previous-buffer :which-key "Previous")
    "bn" '(next-buffer :which-key "Next")
    ))
;;  :bind
;;  ("C-x C-b" . ibuffer))


;; Group buffers by vc dir in ibuffer
(use-package ibuffer-vc
  :init
  (setq ibuffer-formats
      '((mark modified read-only vc-status-mini " "
              (name 18 18 :left :elide)
              " "
              (size 9 -1 :right)
              " "
              (mode 16 16 :left :elide)
              " "
              (vc-status 16 16 :left)
              " "
              vc-relative-file)))
  :hook (ibuffer . (lambda ()
      (ibuffer-vc-set-filter-groups-by-vc-root)
      (unless (eq ibuffer-sorting-mode 'alphabetic)
        (ibuffer-do-sort-by-alphabetic)))))



;;;; Group buffers by project in ibuffer
;;(use-package ibuffer-project
;;  :hook
;;  (ibuffer . (lambda ()
;;	       (setq ibuffer-filter-groups (ibuffer-project-generate-filter-groups))
;;	       (unless (eq ibuffer-sorting-mode 'project-file-relative)
;;		 (ibuffer-do-sort-by-project-file-relative)))))







(provide 'k8x1d-buffers)
