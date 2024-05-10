

(use-package emacs
  :bind
  (:map completion-list-mode-map
	("RET" . minibuffer-choose-completion)
	("C-j" . minibuffer-next-completion)
	("C-k" . minibuffer-previous-completion))
  :config
  ;; prevent minibuffer lock
  (setq enable-recursive-minibuffers t)
  )

(provide 'minibuffer-module)
