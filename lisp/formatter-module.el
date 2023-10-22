;;; package --- Summary

;;; Commentary:

;;; Code:

;; (use-package format-all
;;   :if (not (equal lsp-framework "lsp-bridge"))
;;   :hook ((prog-mode . format-all-ensure-formatter)
;; 	 (prog-mode . format-all-mode)))

;; In test
(use-package apheleia
  :hook (prog-mode . apheleia-mode))


(provide 'formatter-module)
;;; formatter-module.el ends here
