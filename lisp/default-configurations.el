(use-package emacs
  :config
  :hook (
  (after-init . auto-save-visited-mode) ;; automatic autosave to file
  ))


;; Default browser
;; (setq browse-url-browser-function 'browse-url-default-browser)
(setq browse-url-browser-function 'browse-url-firefox)
;; (setq browse-url-browser-function 'browse-url-nyxt)

(provide 'default-configurations)
