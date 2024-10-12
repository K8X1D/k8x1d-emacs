;; -*- lexical-binding: t; -*-


;; Stop cursor blinking, cause cursor to disappear sometime (flycheck diagnostif buffer list for example)
(use-package emacs
  :hook
  (after-init . (lambda () 
		  (blink-cursor-mode 0)
		  ))
  )


  (provide 'cursor-module)
