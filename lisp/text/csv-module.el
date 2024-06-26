(use-package csv-mode
    :mode "\\.\\(tab\\|[tc]sv\\)\\'"
    :bind (:map csv-mode-map
                ("<tab>" . csv-tab-command))
    :hook (
	   (csv-mode . (lambda () (csv-highlight ?\,)))
	   (csv-mode . (lambda () (csv-highlight ?\;)))
	   (csv-mode . (lambda () (csv-highlight ?\11)))
           (csv-mode . csv-align-mode)
           (csv-mode . (lambda () (visual-line-mode -1)))
           ;; (csv-mode . (lambda () (interactive) (toggle-truncate-lines nil)))
           )
    :config
    (setq csv-header-lines 1)
    (setq csv-separators '("," ";" "\11"))
  
    ;; Set a different colour to each column
    (require 'cl)
    (require 'color)

    (defun csv-highlight (&optional separator)
      (interactive (list (when current-prefix-arg (read-char "Separator: "))))
      (font-lock-mode 1)
      (let* ((separator (or separator ?\11))
             (n (count-matches (string separator) (point-at-bol) (point-at-eol)))
             (colors (loop for i from 0 to 1.0 by (/ 2.0 n)
                           collect (apply #'color-rgb-to-hex 
                                          (color-hsl-to-rgb i 0.3 0.5)))))
        (loop for i from 2 to n by 2 
              for c in colors
              for r = (format "^\\([^%c\n]+%c\\)\\{%d\\}" separator separator i)
              do (font-lock-add-keywords nil `((,r (1 '(face (:foreground ,c)))))))))
    )

(provide 'csv-module)
