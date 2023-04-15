;; Inspirations:
;; - https://github.com/Lambda-Emacs/lambda-emacs/blob/main/lambda-library/lambda-setup/lem-setup-tabs.el

;;(use-package tabspaces
;;  :hook (after-init . tabspaces-mode) ;; use this only if you want the minor-mode loaded at startup. 
;;  :commands (tabspaces-switch-or-create-workspace
;;             tabspaces-open-or-create-project-and-workspace)
;;  :custom
;;  (tabspaces-use-filtered-buffers-as-default t)
;;  (tabspaces-default-tab "Default")
;;  (tabspaces-remove-to-default t)
;;  (tabspaces-include-buffers '("*scratch*"))
;;  :config
;;  ;; sessions
;;  ;;(tabspaces-session t)
;;  ;;(tabspaces-session-auto-restore t))
;;  ;;:config
;;  ;;(setq tabspaces-keymap-prefix "SPC TAB")
;;
;;  ;; Tab configuration
;;  ;;(setq tab-bar-show nil)
;;  (setq tab-bar-new-tab-choice "*scratch*"
;;	tab-bar-close-button-show t
;;	tab-bar-new-button-show nil
;;	tab-bar-auto-width t
;;	tab-bar-separator " "
;;	)
;;  (custom-set-faces
;;   '(tab-bar-tab-inactive ((t (:inherit nil :foreground "#928374" :height 1.5))))
;;   '(tab-bar-tab ((t (:foreground "#ebdbb2":weight bold :underline nil :height 1.5))))
;;   )
;;  )




;;;; Tab Bar
;; Use tab-bar for window grouping and configuration within a project (replaces eyebrowse)
(use-package tab-bar
  :after (project)
  :commands (tab-bar-new-tab
             tab-bar-switch-to-tab
             tab-bar-switch-to-next-tab
             tab-bar-switch-to-prev-tab)
  :custom
  (tab-bar-show 1)
  (tab-bar-tab-hints t) ;; show numbers in tabs
  ;; Unless another file/buffer is designated, start from workspace scratch buffer
  (tab-bar-new-tab-choice "*scratch*")
  (tab-bar-select-tab-modifiers '(alt))
  (tab-bar-close-tab-select 'recent)
  (tab-bar-new-tab-to 'rightmost)
  (tab-bar-close-last-tab-choice 'tab-bar-mode-disable)
  (tab-bar-tab-name-format-function #'lem--tab-bar-tab-name-format)
  (tab-bar-new-button nil)
  (tab-bar-close-button nil)
  (tab-bar-format '(tab-bar-format-history
                    tab-bar-format-tabs
                    lem--tab-bar-suffix
                    tab-bar-format-add-tab))
  :config
  ;; Tab bar numbers
  ;; https://christiantietze.de/posts/2022/02/emacs-tab-bar-numbered-tabs/
  (defvar lem-tab-bar--circle-numbers-alist
    '((0 . "⓪")
      (1 . "①")
      (2 . "②")
      (3 . "③")
      (4 . "④")
      (5 . "⑤")
      (6 . "⑥")
      (7 . "⑦")
      (8 . "⑧")
      (9 . "⑨")
      (10 . "⑩")
      (11 . "⑪")
      (12 . "⑫")
      (13 . "⑬")
      (14 . "⑭")
      (15 . "⑮"))

    "Alist of integers to strings of circled unicode numbers.")

  (defun lem--tab-bar-tab-name-format (tab i)
    (let ((current-p (eq (car tab) 'current-tab))
          (tab-num (if (and tab-bar-tab-hints (< i 16))
                       (alist-get i lem-tab-bar--circle-numbers-alist) "")))
      (propertize
       (concat
        " "
        tab-num
        (propertize " " 'display '(space :width (4)))
        (alist-get 'name tab)
        (or (and tab-bar-close-button-show
                 (not (eq tab-bar-close-button-show
                          (if current-p 'non-selected 'selected)))
                 tab-bar-close-button)
            "")
        (propertize " " 'display '(space :width (4))))
       'face (funcall tab-bar-tab-face-function tab))))

  ;; See https://github.com/rougier/nano-modeline/issues/33
  (defun lem--tab-bar-suffix ()
    "Add empty space.
This ensures that the last tab's face does not extend to the end
of the tab bar."
    " ")


  ;; https://protesilaos.com/codelog/2020-08-03-emacs-custom-functions-galore/
  (defun lem-tab-bar-select-tab-dwim ()
    "Do-What-I-Mean function for getting to a `tab-bar-mode' tab.
If no other tab exists, create one and switch to it.  If there is
one other tab (so two in total) switch to it without further
questions.  Otherwise use completion to select the tab."
    (interactive)
    (let ((tabs (mapcar (lambda (tab)
                          (alist-get 'name tab))
                        (tab-bar--tabs-recent))))
      (cond ((eq tabs nil)
             (tab-new))
            ((eq (length tabs) 1)
             (tab-next))
            (t
             (tab-bar-switch-to-tab
              (completing-read "Select tab: " tabs nil t)))))))

;;;; Tab Workspaces
(use-package tabspaces
  ;; Add some functions to the project map
  :bind (:map project-prefix-map
         ("p" . tabspaces-open-or-create-project-and-workspace))
  :hook (emacs-startup . tabspaces-mode)
  :custom
  (tabspaces-use-filtered-buffers-as-default t)
  (tabspaces-default-tab "Home")
  :config
  (defun lem--consult-tabspaces ()
    "Deactivate isolated buffers when not using tabspaces."
    (require 'consult)
    (cond (tabspaces-mode
           ;; hide full buffer list (still available with "b")
           (consult-customize consult--source-buffer :hidden t :default nil)
           (add-to-list 'consult-buffer-sources 'consult--source-workspace))
          (t
           (consult-customize consult--source-buffer :hidden nil :default t)
           (setq consult-buffer-sources (remove #'consult--source-workspace consult-buffer-sources)))))
  (add-hook 'tabspaces-mode-hook #'lem--consult-tabspaces))

;;;;; Consult Isolated Workspace Buffers
;; Filter Buffers for Consult-Buffer

(with-eval-after-load 'consult
  ;; hide full buffer list (still available with "b" prefix)
  (consult-customize consult--source-buffer :hidden t :default nil)
  ;; set consult-workspace buffer list
  (defvar consult--source-workspace
    (list :name     "Workspace Buffers"
          :narrow   ?w
          :history  'buffer-name-history
          :category 'buffer
          :state    #'consult--buffer-state
          :default  t
          :items    (lambda () (consult--buffer-query
                           :predicate #'tabspaces--local-buffer-p
                           :sort 'visibility
                           :as #'buffer-name)))

    "Set workspace buffer list for consult-buffer."))

(provide 'k8x1d-workspaces)


