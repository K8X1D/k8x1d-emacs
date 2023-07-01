

;;
;; Project management
;;
(defun sidebar-toggle ()
  "Toggle both `dired-sidebar' and `ibuffer-sidebar'."
  (interactive)
  (dired-sidebar-toggle-sidebar)
  (ibuffer-sidebar-toggle-sidebar))

;;(add-hook 'dired-sidebar-mode #'dired-git-info-mode)



;;(global-set-key (kbd "C-x p o t") 'multi-vterm-project)
;;(global-set-key (kbd "C-x p o e") 'dired-sidebar-toggle-sidebar)
;;(global-set-key (kbd "C-x p o e") 'sidebar-toggle) ;; bug with ibuffer-sidebar upd

;;(defun sidebar-toggle ()
;;  "Toggle both `dired-sidebar' and `ibuffer-sidebar'."
;;  (interactive)
;;  (dired-sidebar-toggle-sidebar)
;;  (ibuffer-sidebar-toggle-sidebar))


;; Terminal
(use-package vterm
  :hook
  (vterm-mode . visual-line-mode)
)
 ;;  (vterm-mode . (lambda () (setq-local global-hl-line-mode nil)))))


;; (use-package multi-vterm
;;   :bind
;;   ("C-c o t" . multi-vterm-dedicated-toggle)
;;   :config
;;   (setq multi-vterm-dedicated-window-height 18))

;; From https://github.com/suonlight/multi-vterm
(use-package multi-vterm
	:config
	(add-hook 'vterm-mode-hook
			(lambda ()
			(setq-local evil-insert-state-cursor 'box)
			(evil-insert-state)))
	(define-key vterm-mode-map [return]                      #'vterm-send-return)

	(setq vterm-keymap-exceptions nil))
;;	(evil-define-key 'insert vterm-mode-map (kbd "C-e")      #'vterm--self-insert)
;;	(evil-define-key 'insert vterm-mode-map (kbd "C-f")      #'vterm--self-insert)
;;	(evil-define-key 'insert vterm-mode-map (kbd "C-a")      #'vterm--self-insert)
;;	(evil-define-key 'insert vterm-mode-map (kbd "C-v")      #'vterm--self-insert)
;;	(evil-define-key 'insert vterm-mode-map (kbd "C-b")      #'vterm--self-insert)
;;	(evil-define-key 'insert vterm-mode-map (kbd "C-w")      #'vterm--self-insert)
;;	(evil-define-key 'insert vterm-mode-map (kbd "C-u")      #'vterm--self-insert)
;;	(evil-define-key 'insert vterm-mode-map (kbd "C-d")      #'vterm--self-insert)
;;	(evil-define-key 'insert vterm-mode-map (kbd "C-n")      #'vterm--self-insert)
;;	(evil-define-key 'insert vterm-mode-map (kbd "C-m")      #'vterm--self-insert)
;;	(evil-define-key 'insert vterm-mode-map (kbd "C-p")      #'vterm--self-insert)
;;	(evil-define-key 'insert vterm-mode-map (kbd "C-j")      #'vterm--self-insert)
;;	(evil-define-key 'insert vterm-mode-map (kbd "C-k")      #'vterm--self-insert)
;;	(evil-define-key 'insert vterm-mode-map (kbd "C-r")      #'vterm--self-insert)
;;	(evil-define-key 'insert vterm-mode-map (kbd "C-t")      #'vterm--self-insert)
;;	(evil-define-key 'insert vterm-mode-map (kbd "C-g")      #'vterm--self-insert)
;;	(evil-define-key 'insert vterm-mode-map (kbd "C-c")      #'vterm--self-insert)
;;	(evil-define-key 'insert vterm-mode-map (kbd "C-SPC")    #'vterm--self-insert)
;;	(evil-define-key 'normal vterm-mode-map (kbd "C-d")      #'vterm--self-insert)
;;	(evil-define-key 'normal vterm-mode-map (kbd ",c")       #'multi-vterm)
;;	(evil-define-key 'normal vterm-mode-map (kbd ",n")       #'multi-vterm-next)
;;	(evil-define-key 'normal vterm-mode-map (kbd ",p")       #'multi-vterm-prev)
;;	(evil-define-key 'normal vterm-mode-map (kbd "i")        #'evil-insert-resume)
;;	(evil-define-key 'normal vterm-mode-map (kbd "o")        #'evil-insert-resume)
;;	(evil-define-key 'normal vterm-mode-map (kbd "<return>") #'evil-insert-resume))






;; Project
(use-package project
  :general 
  (k8x1d/leader-keys
   "p"  '(:ignore t :which-key "Projects")
   "pp" '(project-switch-project :which-key "Switch")
   "pc" '(project-compile :which-key "Compile")
   "pt" '(multi-vterm-project :which-key "Terminal")
   "pe" '(dired-sidebar-toggle-sidebar :which-key "Explorer")
   "pf" '(project-find-file :which-key "Find file")
   "pd" '(project-find-dir :which-key "Find dir")
   "pr" '(project-find-regexp :which-key "Find regexp")
   )
  :bind
  (("C-x p o t" . multi-vterm-project)
   ("C-x p o e" . dired-sidebar-toggle-sidebar))
  )




(provide 'k8x1d-project)
