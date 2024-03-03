;;; -*- lexical-binding: t -*-
(require 'yasnippet)

(defun yas-ess-iteration-keyword-choice ()
  "Choose the iteration keyword for for-loop"
  (yas-choose-value '("=" "in")))
