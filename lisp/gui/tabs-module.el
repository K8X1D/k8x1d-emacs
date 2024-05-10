;; General configurations
(use-package tab-bar
  :hook (after-init . tab-bar-mode)
  :config
  (setq tab-bar-new-tab-choice "*scratch*")
  (setq tab-bar-select-tab-modifiers '(meta))
  )


;; Tabs visible
(use-package tab-bar
  :if k8x1d/tabs
  :config
  (setq tab-bar-show t)
  (setq tab-bar-new-tab-to 'rightmost)
  ;; (setq tab-bar-tab-name-format-function #'k8x1d/tab-bar-tab-name-format)
  (setq tab-bar-new-button-show nil)
  (setq tab-bar-close-button-show nil)
  ;; (setq tab-bar-auto-width-max '(120 10))
  (setq tab-bar-format '(tab-bar-format-history tab-bar-format-tabs tab-bar-separator tab-bar-format-align-right tab-bar-format-global tab-bar-separator))
  (defun k8x1d/tab-bar-tab-name-current ()
    (format " %s " (tab-bar-tab-name-current))
    )
  ;; (setq tab-bar-tab-name-truncated-max )
  (setq tab-bar-auto-width nil)
  ;; (setq tab-bar-auto-width-min '(20 2))
  ;; (setq tab-bar-auto-width-max '(220 20))
  ;; (setq tab-bar-tabs-function #'k8x1d/tab-bar-tabs)
  (setq tab-bar-tab-name-function #'k8x1d/tab-bar-tab-name-current)
  (setq tab-bar-format '(tab-bar-format-tabs tab-bar-format-align-right tab-bar-format-global tab-bar-separator))
  (defun k8x1d/set-tab-bar-colors ()
    (custom-set-faces
     `(tab-bar-tab ((t (:foreground ,(doom-color 'fg) :background ,(doom-color 'bg) :weight bold))))
     `(tab-bar-tab-inactive ((t (:foreground ,(doom-color 'bg-alt) :background ,(doom-color 'grey)))))
     `(tab-bar ((t (:foreground ,(doom-color 'fg-alt) :background ,(doom-color 'bg)))))
     ))
  (k8x1d/set-tab-bar-colors)
  )

;; Prettify tab-bar
;; (use-package modern-tab-bar
;;   :if k8x1d/tabs
;;   :hook (tab-bar-mode . modern-tab-bar-mode)
;;   :init
;;   (defun k8x1d/set-tab-bar-colors ()
;;     (custom-set-faces
;;      `(modern-tab-bar-tab ((t (:foreground ,(doom-color 'bg) :background ,(doom-color 'green)))))
;;      `(modern-tab-bar-tab-inactive ((t (:foreground ,(doom-color 'bg) :background ,(doom-color 'blue)))))
;;      `(modern-tab-bar ((t (:foreground ,(doom-color 'green) :background ,(doom-color 'bg)))))
;;      `(modern-tab-bar-separator ((t (:foreground ,(doom-color 'magenta)))))
;;      ))
;;   (k8x1d/set-tab-bar-colors)
;;   :config
;;   (setq tab-bar-format '(tab-bar-format-history tab-bar-format-tabs tab-bar-separator tab-bar-format-align-right tab-bar-format-global tab-bar-separator))
;;   )

;; Tabs hidden
(use-package tab-bar
  :if (not k8x1d/tabs)
  :config
  (setq tab-bar-show nil)
  )

(use-package tab-bar-echo-area
  :if (not k8x1d/tabs)
  :hook (tab-bar-mode . tab-bar-echo-area-mode)
  :config
  (setq tab-bar-show nil)
  (defun k8x1d/tab-bar-echo-area-format-tab-name-for-joining (name type _tab index count)
    "Format NAME according to TYPE, INDEX and COUNT."
    (format (cond ((eq type 'current-group) " %s ")
		  ((eq index (1- count)) " %s ")
		  (t " %s "))
	    name))
  (setq tab-bar-echo-area-display-tab-names-format-string "%s")
  (setq tab-bar-echo-area-format-tab-name-functions '(k8x1d/tab-bar-echo-area-format-tab-name-for-joining))
  (defun k8x1d/set-tab-bar-colors ()
    (custom-set-faces
     `(tab-bar-echo-area-tab ((t (:foreground ,(doom-color 'bg) :background ,(doom-color 'green)))))
     ;; `(modern-tab-bar-tab-inactive ((t (:foreground ,(doom-color 'blue) :background ,(doom-color 'bg)))))
     ;; `(modern-tab-bar ((t (:foreground ,(doom-color 'green) :background ,(doom-color 'bg)))))
     ;; `(modern-tab-bar-separator ((t (:foreground ,(doom-color 'magenta)))))
     ))
  (k8x1d/set-tab-bar-colors)
  )

(provide 'tabs-module)
