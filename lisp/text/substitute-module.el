(use-package substitute
  :config
  ;; Set this to nil if you do not like visual feedback on the matching
  ;; target.  Default is t.
  ;; (setq substitute-highlight nil)

  ;; Set this to t if you want to always treat the letter casing
  ;; literally.  Otherwise each command accepts a `C-u' prefix
  ;; argument to do this on-demand.
  (setq substitute-fixed-letter-case t)

  ;; If you want a message reporting the matches that changed in the
  ;; given context.  We don't do it by default.
  (add-hook 'substitute-post-replace-functions #'substitute-report-operation)

  ;; We do not bind any keys.  This is just an idea.  The mnemonic is
  ;; that M-# (or M-S-3) is close to M-% (or M-S-5).
  :bind
  (("C-c r s" . substitute-target-below-point)
   ("C-c r r" . substitute-target-above-point)
   ("C-c r d" . substitute-target-in-defun)
   ("C-c r b" . substitute-target-in-buffer))
  )

(provide 'substitute-module)
