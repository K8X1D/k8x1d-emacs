;;; k8x1d-corrector.el --- Corrective utilities configurations  -*- lexical-binding: t; -*-

;; Copyright (C) 2023  Kevin Kaiser

;; Author: Kevin Kaiser <k8x1d@proton.me>
;; Keywords: files

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

;;

;;; Code:


;;
;; Spell checking
;;
;; Doesn't work well with ltex (e.g. two language definition procedure, two different way of interacting, etc), try without it.
;; (use-package flyspell
;;   :hook ((org-mode . flyspell-mode)
;; 	 (markdown-mode . flyspell-mode))
;;   :config
;;   ;; Aspell compatibility
;;   ;; see https://www.emacswiki.org/emacs/FlySpell#h5o-8
;;   (setq ispell-program-name "aspell"
;; 	ispell-extra-args '("--sug-mode=ultra"
;; 			    "--run-together"))
;;   )

;; (use-package flyspell-correct
;;   :after flyspell
;;   :bind (:map flyspell-mode-map
;; 	      ("C-c $" . flyspell-correct-at-point))
;;   :config
;;   ;; Speedup flyspell
;;   (setq flyspell-issue-welcome-flag nil
;; 	flyspell-issue-message-flag nil)
;;   ;; leave duplication evaluation to langtool
;;   (setq flyspell-mark-duplications-flag nil))

;; (use-package auto-dictionary-mode
;;   :hook (flyspell-mode . auto-dictionary-mode))

;;
;; Good writing
;;

(use-package writegood-mode
  :bind
  (("C-c e g" . writegood-grade-level)
   ("C-c e r" . writegood-reading-ease))
  :hook (text-mode . writegood-mode))

(use-package format-all
  :hook ((prog-mode . format-all-ensure-formatter)
	 (prog-mode . format-all-mode)))

(provide 'k8x1d-corrector)
;;; k8x1d-corrector.el ends here
