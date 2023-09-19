;;; package --- Summary

;;; Commentary:

;;; Code:


;; inspiration
;; - https://github.com/owainlewis/emacs-color-themes/blob/master/themes/ritchie-theme.el

(deftheme k8x1d
  "Created 2023-09-17.")

(defvar k8x1d-colours-alist
  nil
  "Colours for the k8x1d (dark) theme.")

;; From https://github.com/morhetz/gruvbox
(setq k8x1d-colours-alist
      '((white . "#ebdbb2")
	(black . "#282828")
	(pale-black . "#504945")
	(pale-white . "#bdae93")
	(grey . "#928374")
	(pale-grey . "#a89984")
	(red . "#cc241d")
	(pale-red . "#fb4934")
	(green . "#98971a")
	(pale-green . "#b8bb26")
	(yellow . "#d79921")
	(pale-yellow . "#fabd2f")
	(blue . "#458588")
	(pale-blue . "#83a598")
	(purple . "#b16286")
	(pale-purple . "#d3869b")
	(aqua . "#689d6a")
	(pale-aqua . "#8ec07c")
	(orange . "#d65d0e")
	(pale-orange . "#fe8019")
	))

(defun k8x1d-colour (name)
  "Shortcut to get a colour for ``k8x1d-colours-alist'' by NAME."
  (cdr (assoc name k8x1d-colours-alist)))

(if (equal k8x1d-theme-variant "dark")
    (setq
     *bg*                   (k8x1d-colour 'black)
     *bg-alt*               (k8x1d-colour 'pale-black)
     *fg*                   (k8x1d-colour 'white)
     *fg-alt*               (k8x1d-colour 'pale-white)
     *comments*             (k8x1d-colour 'pale-grey)
     *keywords*             (k8x1d-colour 'pale-red)
     *string*               (k8x1d-colour 'pale-green)
     *builtin*              (k8x1d-colour 'pale-purple)
     *function*             (k8x1d-colour 'pale-blue)
     *type*                 (k8x1d-colour 'pale-aqua)
     *variable*             (k8x1d-colour 'pale-orange)
     )
  (setq
   *fg*                    (k8x1d-colour 'black)
   *fg-alt*                (k8x1d-colour 'pale-black)
   *bg*                    (k8x1d-colour 'white)
   *bg-alt*                (k8x1d-colour 'pale-white)
   *comments*              (k8x1d-colour 'grey)
   *keywords*              (k8x1d-colour 'red)
   *string*                (k8x1d-colour 'green)
   *builtin*               (k8x1d-colour 'purple)
   *function*              (k8x1d-colour 'blue)
   *type*                  (k8x1d-colour 'aqua)
   *variable*              (k8x1d-colour 'orange)
   ))

(custom-theme-set-faces
 `k8x1d
 `(default ((t (:inherit nil :extend nil :stipple nil :background, *bg* :foreground, *fg* :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight regular :height 120 :width normal :foundry "UKWN" :family "Iosevka Term"))))
 `(cursor ((t (:background, *fg* :foreground , *bg*))))
 `(fixed-pitch ((t (:family "Iosevka Term" :foundry "UKWN" :width normal :height 1.0 :weight light :slant normal))))
 `(variable-pitch ((t (:family "Iosevka Aile" :foundry "UKWN" :width normal :height 1.0 :weight light :slant normal))))
 `(escape-glyph ((t (:foreground "#85CCC6"))))
 `(vertical-border ((t (:foreground, *fg* :background, *fg*))))
 `(homoglyph ((t (:foreground "#4560E6"))))
 `(minibuffer-prompt ((t (:foreground "#F2DA61" :background "#141414"))))
 `(highlight ((t (:background, *bg-alt*))))
 `(region ((t (:background "#cc241d"))))
 `; temp
 `(edit-indirect-edited-region ((t (:inverse-video t))))
 `(secondary-selection ((t (:inverse-video t))))
 `(shadow ((t (:foreground "#a89984"))))
 `(secondary-selection ((t (:extend t :background "#2c2c34"))))
 `(trailing-whitespace ((t (:background "#474648"))))
 `(font-lock-bracket-face ((t (:inherit (font-lock-punctuation-face)))))
 `(font-lock-builtin-face ((t (:weight light :foreground, *builtin*))))
 `(font-lock-comment-delimiter-face ((default (:inherit (font-lock-comment-face)))))
 `(font-lock-comment-face ((t (:weight normal :slant italic :foreground, *comments*))))
 `(font-lock-constant-face ((t (:weight light :foreground "#EBE9E7"))))
 `(font-lock-delimiter-face ((t (:inherit (font-lock-punctuation-face)))))
 `(font-lock-doc-face ((t (:inherit (font-lock-string-face)))))
 `(font-lock-doc-markup-face ((t (:inherit (font-lock-constant-face)))))
 `(font-lock-escape-face ((t (:inherit (font-lock-regexp-grouping-backslash)))))
 `(font-lock-function-call-face ((t (:inherit (font-lock-function-name-face)))))
 `(font-lock-function-name-face ((t (:weight bold :foreground, *function*))))
 `(font-lock-keyword-face ((t (:weight light :slant italic :foreground, *keywords*))))
 `(font-lock-negation-char-face ((t nil)))
 `(font-lock-number-face ((t nil)))
 `(font-lock-misc-punctuation-face ((t (:inherit (font-lock-punctuation-face)))))
 `(font-lock-operator-face ((t nil)))
 `(font-lock-preprocessor-face ((t (:weight medium :foreground "#EBE9E7"))))
 `(font-lock-property-name-face ((t (:inherit (font-lock-variable-name-face)))))
 `(font-lock-property-use-face ((t (:inherit (font-lock-property-name-face)))))
 `(font-lock-punctuation-face ((t nil)))
 `(font-lock-regexp-grouping-backslash ((t (:inherit (bold)))))
 `(font-lock-regexp-grouping-construct ((t (:inherit (bold)))))
 `(font-lock-string-face ((t (:foreground, *string*))))
 `(font-lock-type-face ((t (:weight light :foreground, *type*))))
 `(font-lock-variable-name-face ((t (:weight light :foreground, *variable*))))
 `(font-lock-variable-use-face ((t (:inherit (font-lock-variable-name-face)))))
 `(font-lock-warning-face ((t (:weight bold :foreground "#CF6752"))))
 `(button ((t (:inherit (link)))))
 `(link ((t (:underline (:color foreground-color :style line :position nil) :foreground "#F5F2F0" :background "#1A1919"))))
 `(link-visited ((default (:inherit (link))) (((class color) (background light)) (:foreground "magenta4")) (((class color) (background dark)) (:foreground "violet"))))
 `(fringe ((t (:weight light :background, *bg*))))
 `(header-line ((default (:inherit (mode-line))) (((type tty)) (:underline (:color foreground-color :style line :position nil) :inverse-video nil)) (((class color grayscale) (background light)) (:box nil :foreground "grey20" :background "grey90")) (((class color grayscale) (background dark)) (:box nil :foreground "grey90" :background "grey20")) (((class mono) (background light)) (:underline (:color foreground-color :style line :position nil) :box nil :inverse-video nil :foreground "black" :background "white")) (((class mono) (background dark)) (:underline (:color foreground-color :style line :position nil) :box nil :inverse-video nil :foreground "white" :background "black"))))
 `(tooltip ((t (:foreground "#212228" :background "#474648"))))
 `(mode-line ((t (:box (:line-width (1 . 1) :color, *fg* :style nil) :foreground, *bg* :background, *fg*))))
 `; '(mode-line ((t (:foreground "#282828" :background "#ebdbb2"))))
 `(mode-line-buffer-id ((t (:weight bold))))
 `(mode-line-emphasis ((t (:weight bold))))
 `(mode-line-highlight ((((supports :box t) (class color) (min-colors 88)) (:box (:line-width (2 . 2) :color "grey40" :style released-button))) (t (:inherit (highlight)))))
 `(mode-line-inactive ((t (:box (:line-width (1 . 1) :color, *fg* :style nil) :foreground, *fg-alt* :background , *bg-alt*))))
 `(isearch ((t (:weight bold :foreground "#212228" :background "#4560E6"))))
 `(isearch-fail ((t (:background "#CF6752"))))
 `(ansi-color-blue ((t (:foreground "#458588"))))
 `(ansi-color-red ((t (:foreground, (k8x1d-colour 'red)))))
 `(ansi-color-green ((t (:foreground, (k8x1d-colour 'green)))))
 `(ansi-color-yellow ((t (:foreground, (k8x1d-colour 'yellow)))))
 `(lazy-highlight ((t (:foreground "#EBE9E7" :background "#F4BF4F"))))
 `(match ((t (:foreground "#1A1919" :background "#4560E6"))))
 `(orderless-match-face-0 ((t (:weight bold))))
 `(next-error ((t (:inherit (region)))))
 `(query-replace ((t (:background "#F4BF4F"))))

 `(line-number ((t (:foreground, *comments*))))
 `(line-number-current-line ((t (:foreground, (k8x1d-colour 'pale-yellow)))))

 `(org-block ((t (:background, *bg-alt* :foreground, *fg-alt*))))
 `(org-block-begin-line ((t (:background, *fg-alt* :foreground, *bg-alt*))))
 `(org-block-end-line ((t (:background, *fg-alt* :foreground, *bg-alt*))))

 `(org-drawer ((t (:foreground, (k8x1d-colour 'pale-blue)))))

 `(org-habit-clear-face ((t (:background, (k8x1d-colour 'pale-blue) :foreground, *fg*))))
 `(org-habit-clear-future-face ((t (:background, (k8x1d-colour 'blue) :foreground, *fg*))))
 `(org-habit-ready-face ((t (:background, (k8x1d-colour 'pale-green) :foreground, *fg*))))
 `(org-habit-ready-future-face ((t (:background, (k8x1d-colour 'green) :foreground, *fg*))))
 `(org-habit-alert-face ((t (:background, (k8x1d-colour 'pale-yellow) :foreground, *fg*))))
 `(org-habit-alert-future-face ((t (:background, (k8x1d-colour 'yellow) :foreground, *fg*))))
 `(org-habit-overdue-face ((t (:background, (k8x1d-colour 'pale-red) :foreground, *fg*))))
 `(org-habit-overdue-future-face ((t (:background, (k8x1d-colour 'red) :foreground, *fg*))))

 `(org-modern-tag ((t (:background, *fg-alt* :foreground, *bg-alt*))))


 `(font-latex-italic-face ((t (:foreground, *string*))))

 )

(provide-theme 'k8x1d)
;;; k8x1d-theme.el ends here
