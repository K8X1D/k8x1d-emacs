

(use-package elfeed
  :defer t
  :init
  (defun k8x1d/open-updated-feed ()
    (interactive)
    (elfeed-update)
    (elfeed))
  :bind (("C-c o f" . k8x1d/open-updated-feed))
  :config
  (setq elfeed-feeds '("https://www.fsf.org/static/fsforg/rss/blogs.xml"
		       "http://www.fsf.org/static/fsforg/rss/news.xml"
		       "https://dailynous.com/feed/"
		       "https://guix.gnu.org/feeds/blog.atom"))
)





(provide 'k8x1d-news)
