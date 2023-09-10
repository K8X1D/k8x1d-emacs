;;; k8x1d-fonts.el --- Fonts configuration for k8x1d-emacs  -*- lexical-binding: t; -*-

;; Copyright (C) 2023  Kevin Kaiser

;; Author: Kevin Kaiser <k8x1d@proton.me>
;; Keywords: extensions

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

(use-package emacs
  :config
  ;; Main typeface
  (set-face-attribute 'default nil
		      :font "Iosevka Term"
		      ;; :font "DejaVu Sans Mono"
		      :height 120
		      )
  ;; Set the fixed pitch face
  (set-face-attribute 'fixed-pitch nil
		      :font "Iosevka Term"
		      :weight 'light
		      ;; :font "DejaVu Sans Mono"
		      ;; :weight 'normal
		      :height 1.0
		      )
  ;; Set the variable pitch face
  (set-face-attribute 'variable-pitch nil
		      :font "Iosevka Aile"
		      :weight 'light
		      ;; :font "DejaVu Sans"
		      ;; :weight 'normal
		      :height 1.0
		      )
  )


(use-package fontset
  :straight (:type built-in) ;; only include this if you use straight
  :config
  ;; Use symbola for proper unicode
  (when (member "Symbola" (font-family-list))
    (set-fontset-font
     t 'symbol "Symbola" nil)))

(use-package mixed-pitch
  :hook
  (text-mode . mixed-pitch-mode))

(provide 'k8x1d-fonts)
;;; k8x1d-fonts.el ends here
