(use-package org
  :general
  (k8x1d/leader-keys
   "oa" '(org-agenda :which-key "Agenda")
   "oc" '(org-clock-goto :which-key "Clock")
   )
  :bind
  (("C-c l" . org-store-link)
   :map org-mode-map
   ("C-<return>" . +org/insert-item-below)
   ("C-S-<return>" . +org/insert-item-above))
  :hook
  ((org-mode . org-indent-mode)
   (org-mode . visual-line-mode))
  :config
  (setq org-cite-global-bibliography '("~/Zotero/k8x1d.bib"))
  (setq org-image-actual-width nil)

  ;; TODO: repair problem adding bullet for DONE
  ;; Message: car: Symbol’s function definition is void: +org-get-todo-keywords-for
  ;; Item addition (from doom emacs)
  ;; from https://github.com/doomemacs/doomemacs/blob/master/modules/lang/org/autoload/org.el
  (defun +org-get-todo-keywords-for (&optional keyword)
    "Returns the list of todo keywords that KEYWORD belongs to."
    (when keyword
      (cl-loop for (type . keyword-spec)
	       in (cl-remove-if-not #'listp org-todo-keywords)
	       for keywords =
	       (mapcar (lambda (x) (if (string-match "^\\([^(]+\\)(" x)
				       (match-string 1 x)
				     x))
		       keyword-spec)
	       if (eq type 'sequence)
	       if (member keyword keywords)
	       return keywords)))

  (defun +org--insert-item (direction)
    (let ((context (org-element-lineage
		    (org-element-context)
		    '(table table-row headline inlinetask item plain-list)
		    t)))
      (pcase (org-element-type context)
	;; Add a new list item (carrying over checkboxes if necessary)
	((or `item `plain-list)
	 (let ((orig-point (point)))
	   ;; Position determines where org-insert-todo-heading and `org-insert-item'
	   ;; insert the new list item.
	   (if (eq direction 'above)
	       (org-beginning-of-item)
	     (end-of-line))
	   (let* ((ctx-item? (eq 'item (org-element-type context)))
		  (ctx-cb (org-element-property :contents-begin context))
		  ;; Hack to handle edge case where the point is at the
		  ;; beginning of the first item
		  (beginning-of-list? (and (not ctx-item?)
					   (= ctx-cb orig-point)))
		  (item-context (if beginning-of-list?
				    (org-element-context)
				  context))
		  ;; Horrible hack to handle edge case where the
		  ;; line of the bullet is empty
		  (ictx-cb (org-element-property :contents-begin item-context))
		  (empty? (and (eq direction 'below)
			       ;; in case contents-begin is nil, or contents-begin
			       ;; equals the position end of the line, the item is
			       ;; empty
			       (or (not ictx-cb)
				   (= ictx-cb
				      (1+ (point))))))
		  (pre-insert-point (point)))
	     ;; Insert dummy content, so that `org-insert-item'
	     ;; inserts content below this item
	     (when empty?
	       (insert " "))
	     (org-insert-item (org-element-property :checkbox context))
	     ;; Remove dummy content
	     (when empty?
	       (delete-region pre-insert-point (1+ pre-insert-point))))))
	;; Add a new table row
	((or `table `table-row)
	 (pcase direction
	   ('below (save-excursion (org-table-insert-row t))
		   (org-table-next-row))
	   ('above (save-excursion (org-shiftmetadown))
		   (+org/table-previous-row))))

	;; Otherwise, add a new heading, carrying over any todo state, if
	;; necessary.
	(_
	 (let ((level (or (org-current-level) 1)))
	   ;; I intentionally avoid `org-insert-heading' and the like because they
	   ;; impose unpredictable whitespace rules depending on the cursor
	   ;; position. It's simpler to express this command's responsibility at a
	   ;; lower level than work around all the quirks in org's API.
	   (pcase direction
	     (`below
	      (let (org-insert-heading-respect-content)
		(goto-char (line-end-position))
		(org-end-of-subtree)
		(insert "\n" (make-string level ?*) " ")))
	     (`above
	      (org-back-to-heading)
	      (insert (make-string level ?*) " ")
	      (save-excursion (insert "\n"))))
	   (run-hooks 'org-insert-heading-hook)
	   (when-let* ((todo-keyword (org-element-property :todo-keyword context))
		       (todo-type    (org-element-property :todo-type context)))
	     (org-todo
	      (cond ((eq todo-type 'done)
		     ;; Doesn't make sense to create more "DONE" headings
		     (car (+org-get-todo-keywords-for todo-keyword)))
		    (todo-keyword)
		    ('todo)))))))

      (when (org-invisible-p)
	(org-show-hidden-entry))
      (when (and (bound-and-true-p evil-local-mode)
		 (not (evil-emacs-state-p)))
	(evil-insert 1))))

  (defun +org/insert-item-below (count)
    "Inserts a new heading, table cell or item below the current one."
    (interactive "p")
    (dotimes (_ count) (+org--insert-item 'below)))

  (defun +org/insert-item-above (count)
    "Inserts a new heading, table cell or item above the current one."
    (interactive "p")
    (dotimes (_ count) (+org--insert-item 'above)))

  ;; Agenda
  ;; take the whole buffer
  (setq org-agenda-window-setup 'current-window)
  ;; Show 10 day (3 before, 7 after)
  (setq
   org-agenda-span 10
   org-agenda-start-on-weekday nil
   org-agenda-start-day "-3d")
  ;; Optimize startup 
  (setq org-agenda-inhibit-startup t)

  ;; Babel
  (setq org-confirm-babel-evaluate nil)
  (defalias 'org-babel-execute:julia 'org-babel-execute:julia-vterm)
  (defalias 'org-babel-variable-assignments:julia 'org-babel-variable-assignments:julia-vterm)
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((sql . t)
     (julia-vterm . t)))

  ;; Src block
  (setq org-src-preserve-indentation t)
  )

;;(use-package org-modern
;;  :hook (after-init . global-org-modern-mode)
;; ;; :custom
;;;;  (org-modern-table nil)
;;  :config
;;  ;; Tmp fix, see https://github.com/minad/org-modern/issues/5
;;  (custom-set-variables '(org-modern-table nil))
;;  (setq
;;   ;; Edit settings
;;   org-auto-align-tags nil
;;   org-tags-column 0
;;   org-catch-invisible-edits 'show-and-error
;;   org-special-ctrl-a/e t
;;   org-insert-heading-respect-content t
;;
;;   ;; Org styling, hide markup etc.
;;   org-pretty-entities t
;;   org-ellipsis "…"
;;
;;   ;; Agenda styling
;;   org-agenda-tags-column 0
;;   org-agenda-block-separator ?─
;;   org-agenda-time-grid
;;   '((daily today require-timed)
;;     (800 1000 1200 1400 1600 1800 2000)
;;     " ┄┄┄┄┄ " "┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄")
;;   org-agenda-current-time-string
;;   "⭠ now ─────────────────────────────────────────────────")
;;  )

;; Prettify bullets
(use-package org-superstar
  :hook
  (org-mode . org-superstar-mode)
  :config
  ;; This is usually the default, but keep in mind it must be nil
  (setq org-hide-leading-stars nil)
  ;; This line is necessary.
  (setq org-superstar-leading-bullet ?\s)
  ;; If you use Org Indent you also need to add this, otherwise the
  ;; above has no effect while Indent is enabled.
  (setq org-indent-mode-turns-on-hiding-stars nil)
  (setq org-superstar-special-todo-items nil)

  (setq org-superstar-headline-bullets-list '("◉" "○" "●" "◈" "◇" "◆" "▣" "□" "■"))
  (setq org-superstar-item-bullet-alist '((?* . ?•)
					  (?+ . ?➤)
					  (?- . ?•)))
  )

;; Prettify priorities
(use-package org-fancy-priorities
  :hook
  (org-mode . org-fancy-priorities-mode)
  :config
  (setq org-fancy-priorities-list '("[!]" "[*]" "[-]")))


(use-package org-auto-tangle
  :hook (org-mode . org-auto-tangle-mode))

;;;; FIXME: don't work
(use-package org-appear
  :init
  (add-hook 'org-mode-hook (lambda ()
			     (add-hook 'evil-insert-state-entry-hook
				       #'org-appear-manual-start
				       nil
				       t)
			     (add-hook 'evil-insert-state-exit-hook
				       #'org-appear-manual-stop
				       nil
				       t)))
  :hook
  (org-mode . org-appear-mode)
  :config
  (setq org-hide-emphasis-markers t
	org-appear-trigger 'manual
	;;org-appear-trigger 'always
	org-appear-autoentities t
	org-appear-autosubmarkers t
	org-appear-autokeywords t
	org-appear-inside-latex t
	org-appear-autoemphasis t
	org-appear-autolinks t)
  )


;; Table of content
;; From https://github.com/doomemacs/doomemacs/blob/master/modules/lang/org/config.el
(use-package toc-org
  ;;:bind (:map markdown-mode-map
  ;;	      ("C-c C-o" . toc-org-markdown-follow-thing-at-point))
  :hook ((org-mode . toc-org-mode)
	 (markdown-mode . toc-org-mode))
  :config
  (setq toc-org-hrefify-default "gh"))

(provide 'k8x1d-org)
