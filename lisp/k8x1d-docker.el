;;; package --- Summary

;;; Commentary:

;;; Code:



(use-package docker
  :bind ("C-c o d" . docker))
(use-package dockerfile-mode)
(use-package tramp-container
  :straight (:type built-in) ;; only include this if you use straight
  )
(use-package docker-compose-mode)





(provide 'k8x1d-docker)
;;; k8x1d-docker.el ends here
