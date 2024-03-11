
;; Set-up for use-package
(require 'use-package-ensure)
(setq use-package-always-ensure nil)
;; Daemon set-up
(if (daemonp)
    (setq use-package-always-demand t)
  (setq use-package-always-defer t))
;; (setq use-package-always-pin "nongnu") ;; prefer release version

;; Add melpa to archive
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;; (add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))



(provide 'packages-module)
