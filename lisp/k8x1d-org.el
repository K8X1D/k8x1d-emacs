(use-package org
  :general
  (k8x1d/leader-keys
   "oa" '(org-agenda :which-key "Agenda")
   "fc" '(org-clock-goto :which-key "Clock")
   "X" '(org-capture :which-key "Capture")
   )
  (k8x1d/local-leader-keys
    :keymaps 'org-mode-map
    "p" '(org-priority :which-key "Priority")
    "it" '(org-insert-structure-template :which-key "Template")
    "il" '(org-insert-link :which-key "Link")
    "f" '(org-footnote-action :which-key "Footnotes")
    )
  :bind
  (("C-c l" . org-store-link)
   :map org-mode-map
   ("C-<return>" . +org/insert-item-below)
   ("C-S-<return>" . +org/insert-item-above)
   )
  :hook
  ((org-mode . org-indent-mode)
   (org-mode . visual-line-mode))
  :config
  ;; Footnotes
  (setq org-footnote-auto-adjust t)

  ;; Prettify
  (setq org-pretty-entities t) ;;
  (setq org-pretty-entities-include-sub-superscripts nil) ;; prettify don't work well with citar
  (setq org-fontify-quote-and-verse-blocks t)

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
     (shell . t)
     (julia . t)
     (scheme . t)
     (R . t)
     (python . t)))

  ;; Src block
  (setq org-src-preserve-indentation t)

  )


;; (use-package org-modern
;;   :hook ((org-mode . org-modern-mode)
;; 	 (org-agenda-finalize . org-modern-agenda))
;;   :config
;;   ;; Edit settings
;;   (setq org-auto-align-tags nil)
;;   (setq org-tags-column 0)
;;   (setq org-catch-invisible-edits 'show-and-error)
;;   (setq org-special-ctrl-a/e t)
;;   (setq org-insert-heading-respect-content t)

;;   ;; Org styling, hide markup etc.
;;   (setq org-hide-emphasis-markers t)
;;   (setq org-pretty-entities t)
;;   (setq org-ellipsis "…")

;;   ;; Agenda styling
;;   (setq org-agenda-tags-column 0)
;;   (setq org-agenda-block-separator ?─)
;;   (setq org-agenda-time-grid
;; 	'((daily today require-timed)
;; 	  (800 1000 1200 1400 1600 1800 2000)
;; 	  " ┄┄┄┄┄ " "┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄"))
;;   (setq org-agenda-current-time-string "⭠ now ─────────────────────────────────────────────────")
;;   )

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

(use-package org-agenda
  :bind
  (:map org-agenda-mode-map
   ("C-SPC" . org-agenda-show-and-scroll-up)))

;; Prettify priorities
(use-package org-fancy-priorities
  :defer t
  :hook
  (org-mode . org-fancy-priorities-mode)
  :config
  (setq org-fancy-priorities-list '("[!]" "[*]" "[-]")))



;; Prettify tags 
(use-package svg-tag-mode
  :init
  ;; Set faces
  (defface svg-tag-todo '((t (:inherit org-todo  :height 0.5))) "Face for todo")
  (defface svg-tag-wait '((t (:inherit +org-todo-onhold :height 0.5))) "Face for wait")
  (defface svg-tag-kill '((t (:inherit +org-todo-cancel :height 0.5))) "Face for kill")
  (defface svg-tag-done '((t (:inherit org-done  :height 0.5))) "Face for done")


  (defface svg-tag-proj '((t (:inherit +org-todo-project  :height 0.5))) "Face for proj")
  (defface svg-tag-loop '((t (:inherit org-todo  :height 0.5))) "Face for loop")
  (defface svg-tag-strt '((t (:inherit +org-todo-active  :height 0.5))) "Face for strt")
  (defface svg-tag-hold '((t (:inherit +org-todo-onhold  :height 0.5))) "Face for hold")
  (defface svg-tag-idea '((t (:inherit org-todo  :height 0.5))) "Face for idea")
  ;; Org agenda tweak for showing svg
  (defun org-agenda-show-svg ()
    (let* ((case-fold-search nil)
           (keywords (mapcar #'svg-tag--build-keywords svg-tag--active-tags))
           (keyword (car keywords)))
      (while keyword
        (save-excursion
          (while (re-search-forward (nth 0 keyword) nil t)
            (overlay-put (make-overlay
                          (match-beginning 0) (match-end 0))
                         'display  (nth 3 (eval (nth 2 keyword)))) ))
        (pop keywords)
        (setq keyword (car keywords)))))

  ;; fix font problem, see https://github.com/rougier/svg-tag-mode/issues/38;; Don't work for new tags
  ;;(add-hook 'after-setting-font-hook (lambda () (setq svg-lib-style-default (svg-lib-style-compute-default))))
 ;; :hook ((org-mode . svg-tag-mode)
 ;;	 (org-agenda-mode . svg-tag-mode)
 ;;	 (org-agenda-finalize . org-agenda-show-svg))
  :config
  ;; fix font problem, see https://github.com/rougier/svg-tag-mode/issues/38
  ;; (plist-put svg-lib-style-default :font-family "Iosevka Term")
  ;; (plist-put svg-lib-style-default :font-size 14)
  ;; (setq tree-sitter-hl-use-font-lock-keywords t)
  (setq svg-tag-tags
	'(
	  ("TODO" . ((lambda (tag) (svg-tag-make "TODO" :face 'svg-tag-todo :inverse t))))
	  ("WAIT" . ((lambda (tag) (svg-tag-make "WAIT" :face 'svg-tag-wait :inverse t))))
	  ("KILL" . ((lambda (tag) (svg-tag-make "KILL" :face 'svg-tag-kill :inverse t))))
	  ("DONE" . ((lambda (tag) (svg-tag-make "DONE" :face 'svg-tag-done :inverse t))))
	  ("PROJ" . ((lambda (tag) (svg-tag-make "PROJ" :face 'svg-tag-proj :inverse t))))
	  ("LOOP" . ((lambda (tag) (svg-tag-make "LOOP" :face 'svg-tag-loop :inverse t))))
	  ("STRT" . ((lambda (tag) (svg-tag-make "STRT" :face 'svg-tag-strt :inverse t))))
	  ("HOLD" . ((lambda (tag) (svg-tag-make "HOLD" :face 'svg-tag-hold :inverse t))))
	  ("IDEA" . ((lambda (tag) (svg-tag-make "IDEA" :face 'svg-tag-idea :inverse t))))

	  ;;(":.+:" . ((lambda (tag) (svg-tag-make tag))))
	  ("#\\+[A-Z]+:" . ((lambda (tag) (svg-tag-make tag))))
	  )
	)
  )

(use-package org-auto-tangle
  :hook (org-mode . org-auto-tangle-mode))

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



;; Specific timers
(use-package org
  :init
  (defun k8x1d/daily-thesis-timer ()
    (interactive)
    (require 'org)
    (org-timer-set-timer "00:10:00")
    )
  :config
  (setq org-clock-sound "~/Music/Soundtracks/Fargo_season_1/test.wav")
  (setq org-clock-clocked-in-display "frame-title")
  )

;; Inspirations:
;; - https://github.com/japhir/ArchConfigs/blob/master/myinit.org#play-bell-sound-when-task-is-marked-as-done 
;; Clumsy, try native org function
(use-package org-pomodoro
  :after org
  :general
  (k8x1d/local-leader-keys
    :keymaps 'org-mode-map
    "P" '(k8x1d/org-pomodoro-custom-time :which-key "Pomodoro")
    )
  :hook (org-pomodoro-break-finished . k8x1d/org-pomodoro-prompt)
  :config
  (setq org-pomodoro-manual-break t)
  (setq org-pomodoro-length 50)
  ;;(setq org-pomodoro-length 0.1) ;; for test
  (setq org-pomodoro-short-break-length 10)
  (setq org-pomodoro-long-break-length 30)
  (setq org-pomodoro-start-sound "~/Music/Sounds/hourly_dong.wav")
  (setq org-pomodoro-short-break-sound "~/Music/Soundtracks/Fargo_season_1/test.wav")
  (setq org-pomodoro-long-break-sound "~/Music/Sounds/hourly_dong.wav")
  (setq org-pomodoro-overtime-sound "~/Music/Soundtracks/Fargo_season_1/test.wav")
  (setq org-pomodoro-finished-sound "~/Music/Sounds/hourly_dong.wav")
  (setq org-pomodoro-audio-player "mpv")

  (defun k8x1d/org-pomodoro-prompt ()
    (interactive)
    (org-clock-goto)
    (if (y-or-n-p "Start a new pomodoro?")
        (progn
          (k8x1d/org-pomodoro-custom-time))))

  (defun k8x1d/org-pomodoro-custom-time (min)
    "Set pomodoro with custom time pomodoro-time"
    (interactive "nSet pomodoro (total) length (in min): ")
        (progn
	  ;; keep original values
	  (setq org-pomodoro-length-initial-value org-pomodoro-length)
	  (setq org-pomodoro-short-break-length-initial-value org-pomodoro-short-break-length)
	  (setq org-pomodoro-long-break-initial-value org-pomodoro-long-break-length)
	  ;; Set new values
	  ;;(setq org-pomodoro-length (floor (* min 0.9)))
	  ;;(setq org-pomodoro-short-break-length (ceiling (* min 0.1)))
	  ;;(setq org-pomodoro-long-break-length (floor (* min 0.5)))
	  (setq org-pomodoro-short-break-length (/ min (/ org-pomodoro-length-initial-value org-pomodoro-short-break-length-initial-value)))
	  (setq org-pomodoro-length (- (* org-pomodoro-short-break-length (/ org-pomodoro-length-initial-value org-pomodoro-short-break-length-initial-value)) org-pomodoro-short-break-length))
	  (setq org-pomodoro-long-break-length (/ org-pomodoro-length 2))
	  ;; Start pomodoro
          (org-pomodoro)
	  ;; Set back original values
	  (setq org-pomodoro-length org-pomodoro-length-initial-value)
	  (setq org-pomodoro-short-break-length org-pomodoro-short-break-length-initial-value)
	  (setq org-pomodoro-long-break-length org-pomodoro-long-break-initial-value)
	  ))
  )

;; (use-package org-pdftools
;;   :after (org pdf-tools)
;;   :hook (org-mode . org-pdftools-setup-link))

(provide 'k8x1d-org)
