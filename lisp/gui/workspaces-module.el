(use-package tab-bar
  :after doom-themes
  :init
  (defun k8x1d/tab-bar-tab-name-format (tab i)
    (let ((name (copy-sequence (alist-get 'name tab))))
      (run-hook-wrapped 'tab-bar-tab-name-format-functions
			(lambda (fun)
			  ;; (setq name (funcall fun name tab i))
			  (setq name (concat " " (funcall fun name tab i) " "))
			  nil))
      name))
  ;; FIXME: work once and not after...
  (defun k8x1d/set-tab-bar-colors ()
    (custom-set-faces
     `(tab-bar ((t (:underline (:color ,(doom-color 'green)  :style line :position t) :foreground ,(doom-color 'green)))))
     `(tab-bar-tab ((t (:foreground ,(doom-color 'green) :background ,(doom-color 'bg) :weight bold :height 1.3 :box (:line-width (1 . 1) :color ,(doom-color 'green) :style flat-button) :underline (:color ,(doom-color 'bg)  :style line :position t)))))
     `(tab-bar-tab-inactive ((t (:foreground ,(doom-color 'blue) :background ,(doom-color 'bg-alt) :height 1.3))))
     ))
  :hook (after-init . tab-bar-mode)
  :config
  (setq tab-bar-show t)
  (setq tab-bar-new-button-show nil)
  (setq tab-bar-close-button-show nil)
  (setq tab-bar-new-tab-choice "*scratch*")
  (setq tab-bar-auto-width-max '(100 10))
  (setq tab-bar-new-tab-to 'rightmost)
  (setq tab-bar-select-tab-modifiers '(meta))
  (setq tab-bar-tab-name-format-function #'k8x1d/tab-bar-tab-name-format)
  (setq tab-bar-format '(tab-bar-format-history tab-bar-format-tabs tab-bar-separator tab-bar-format-align-right tab-bar-format-global tab-bar-separator))
  (k8x1d/set-tab-bar-colors)
  )

(provide 'workspaces-module)
