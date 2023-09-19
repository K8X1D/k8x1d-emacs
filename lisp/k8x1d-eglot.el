;;; k8x1d-eglot.el --- Native lsp configuration      -*- lexical-binding: t; -*-

;; Copyright (C) 2023  Kevin Kaiser

;; Author: Kevin Kaiser <k8x1d@proton.me>
;; Keywords: c, c

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;;; Code:

(use-package eglot
  :init
  (setq eglot-connect-timeout 90) ;; prevent eglot timeout
  :general
  ;; Set to local instead
  ;; (k8x1d/leader-keys
  ;;   "l" '(:ignore t :which-key "LSP")
  ;;   "la" '(eglot-code-actions :which-key "Action")
  ;;   "lc" '(eglot-show-workspace-configuration :which-key "Show config")
  ;;   "lf" '(:ignore t :which-key "Format")
  ;;   "lfr" '(eglot-format :which-key "Region")
  ;;   "lff" '(eglot-format-buffer :which-key "File")
  ;;   "ld" '(eglot-shutdown :which-key "Disconnect")
  ;;   "lD" '(eglot-shutdown-all :which-key "Disconnect all"))
  (k8x1d/local-leader-keys
    :keymaps 'eglot-mode-map
    "L" '(:ignore t :which-key "LSP")
    "La" '(eglot-code-actions :which-key "Action")
    "Lc" '(eglot-show-workspace-configuration :which-key "Show config")
    "K" '(eldoc :which-key "Documentation")
    "Lf" '(:ignore t :which-key "Format")
    "Lfr" '(eglot-format :which-key "Region")
    "Lff" '(eglot-format-buffer :which-key "File")
    "Ld" '(eglot-shutdown :which-key "Disconnect")
    "LD" '(eglot-shutdown-all :which-key "Disconnect all"))
  :hook
  ((ess-r-mode . eglot-ensure)
   (r-ts-mode . eglot-ensure)
   (julia-mode . eglot-ensure)
   (julia-ts-mode . eglot-ensure)
   (python-mode . eglot-ensure)
   (python-ts-mode . eglot-ensure)
   (lua-mode . eglot-ensure)
   (scheme-mode . eglot-ensure)
   (LaTeX-mode . eglot-ensure)
   ;; (text-mode . eglot-ensure) ;; ltex-ls is not working properly...
   )
  :config
  ;; eldoc
  ;;(setq eldoc-idle-delay nil)

  ;; Extra language support
  (add-to-list 'eglot-server-programs '(r-ts-mode . ("R" "--slave" "-e" "languageserver::run()")))
  (add-to-list 'eglot-server-programs '(ess-r-mode . ("R" "--slave" "-e" "languageserver::run()")))
  (add-to-list 'eglot-server-programs '(julia-ts-mode . ("julia" "--project=~/.julia/packages/LanguageServer/0vsx2/src" "-e" "using LanguageServer; runserver()")))
  (add-to-list 'eglot-server-programs '(lua-mode . ("lua-language-server")))
  (add-to-list 'eglot-server-programs '(scheme-mode . ("guile-lsp-server")))
  (add-to-list 'eglot-server-programs '(LaTeX-mode . ("texlab")))
  ;; FIXME: ltex don't start properly
  ;; FIXME: ltex don't ignore latex env
  ;; FIXME: ltex don't ignore org markup
  ;; (add-to-list 'eglot-server-programs '(text-mode . ("ltex-ls")))
  )


;; (use-package eglot-ltex
;;   :if (equal k8x1d-lsp-module "eglot")
;;   :hook (text-mode . (lambda ()
;;                        (require 'eglot-ltex)
;;                        (eglot-ensure)))
;;   :init
;;  ;; (setq eglot-languagetool-server-path "/home/k8x1d/.nix-profile/") ;; don't work properly, slow to start if it start
;;  (setq eglot-languagetool-server-path "/home/k8x1d/.cache/emacs/ltex-ls-15.2.0/")
;;   )




(provide 'k8x1d-eglot)
;;; k8x1d-eglot.el ends here
