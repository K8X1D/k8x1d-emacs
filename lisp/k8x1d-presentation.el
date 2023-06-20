;; Inspired from https://notabug.org/dlmayhem/terror-emacs/src/master/init.el

(defun terror/slide-setup ()
  (global-hl-line-mode -1)
  (setq org-hide-emphasis-markers t)
  (org-superstar-mode 1)
  (setq text-scale-mode-amount 3)
  (text-scale-mode 1)
  (set-frame-parameter (selected-frame)
                       'internal-border-width 75)
  (org-display-inline-images)
  (toggle-frame-fullscreen)
  (hide-mode-line-mode 1)
  (hide-lines-matching "#\\+begin")
  (hide-lines-matching "#\\+end"))

(defun terror/slide-end ()
  (global-hl-line-mode 1)
  (setq org-hide-emphasis-markers nil)
  (org-superstar-mode -1)
  (text-scale-mode -1)
  (set-frame-parameter (selected-frame)
                       'internal-border-width 0)
  (toggle-frame-fullscreen)
  (hide-mode-line-mode -1)
  (hide-lines-show-all))

(use-package org-tree-slide
  :after org
  :bind ("C-c p" . org-tree-slide-mode)
  :hook ((org-tree-slide-play . terror/slide-setup)
         (org-tree-slide-stop . terror/slide-end))
  :config
  (setq org-tree-slide-slide-in-effect nil
        org-image-actual-width nil
        org-tree-slide-header t
        org-tree-slide-breadcrumbs " > "
        org-tree-slide-activate-message "Let's begin..."
        org-tree-slide-deactivate-message "The end :)"))

(provide 'k8x1d-presentation)
