;; -*- lexical-binding: t -*-


(use-package elfeed
  :config
  (setq elfeed-feeds 
	'(;; News
	  ("https://ici.radio-canada.ca/rss/4159" news actuality text) ;; Grands titres
	  ;; ("https://ici.radio-canada.ca/rss/1000524" news) ;; Continu
	  ("https://ici.radio-canada.ca/rss/5717" news canada economy text) ;; Économie
	  ("https://ici.radio-canada.ca/rss/92408" news canada environment text) ;; Environment
	  ("https://ici.radio-canada.ca/rss/4175" news canada politic text) ;; Politique
	  ("https://www.lesoir.be/rss/2/cible_principale" news actuality text) ;; La une
	  ("https://www.lesoir.be/rss/11/cible_principale" news belgium economy text) ;; Économie
	  ("https://itsfoss.com/rss/" foss text)

	  ;; Youtube chains
	  ("https://yewtu.be/feed/channel/UCl2mFZoRqjw_ELax4Yisf6w" foss video)
	  ("https://yewtu.be/feed/channel/UCxyXmU3VcCPAJ56nhoOuPiw" music video) ;; I'm a cyborg and that's ok
	  ("https://yewtu.be/feed/channel/UCq-8pBMM3I40QlrhM9ExXJQ" science zetetic video)
	  ("https://yewtu.be/feed/channel/UCybBViio_TH_uiFFDJuz5tg" philo video)
	  ("https://yewtu.be/feed/channel/UC3SyoB0UuS2rsLWcU37eQ2w" games series video)
	  ("https://www.thinkerview.com/rss" divers video)
	  ("https://yewtu.be/feed/channel/UC5UAwBUum7CPN5buc-_N1Fw" foss linux video)
	  ("https://yewtu.be/feed/channel/UCmb8hO2ilV9vRa8cilis88A" engineering scam video)
	  ("https://yewtu.be/feed/channel/UC0cd_-e49hZpWLH3UIwoWRA" science scam video)
	  ("https://yewtu.be/feed/channel/UCqA8H22FwgBVcF3GJpp0MQw" philo video)
	  ("https://yewtu.be/feed/channel/UCaiVt4r6YLPzJVgr7pOmD6w" redpill video)
	  ("https://yewtu.be/feed/channel/UC072bEQ_9-RApe19IbWH9VQ" culture video)

	  ;; Databases
	  ("https://www.ncbi.nlm.nih.gov/feed/rss.cgi?ChanKey=PubMedNews" ncbi db)

	  ;; Health
	  ("https://medlineplus.gov/feeds/topics/infertility.xml" health fertility)
	  ("https://medlineplus.gov/feeds/topics/maleinfertility.xml" health fertility men)
	  ("https://medlineplus.gov/feeds/topics/menshealth.xml" health men)
	  ("https://medlineplus.gov/feeds/topics/prostatecancer.xml" health cancer men prostate)
	  ("https://medlineplus.gov/feeds/topics/preconceptioncare.xml" health conception)
	  ("https://medlineplus.gov/feeds/topics/reproductivehazards.xml" health reproduction)
	  ("https://medlineplus.gov/feeds/topics/benefitsofexercise.xml" health exercice)
	  ("https://medlineplus.gov/feeds/topics/sportssafety.xml" health sports)
	  ("https://medlineplus.gov/feeds/topics/anxiety.xml" health anxiety)
	  ("https://medlineplus.gov/feeds/topics/attentiondeficithyperactivitydisorder.xml" health adhd)
	  ("https://medlineplus.gov/feeds/topics/autismspectrumdisorder.xml" health autism)
	  ("https://medlineplus.gov/feeds/topics/howtoimprovementalhealth.xml" health mental)
	  ("https://medlineplus.gov/feeds/topics/mentalhealth.xml" health mental)
	  ("https://medlineplus.gov/feeds/topics/mooddisorders.xml" health mood)
	  ("https://medlineplus.gov/feeds/topics/personalitydisorders.xml" health personality)

	  ;; Cinema
	  ("https://yewtu.be/feed/channel/UCUyvQV2JsICeLZP4c_h40kA" video cinema)
	  ("https://yewtu.be/feed/channel/UCs7nPQIEba0T3tGOWWsZpJQ" video cinema)
	  ("https://yewtu.be/feed/channel/UCJKLIcSts_4XpVbORwzLZVw" video cinema)

	  ;; Blog
	  ("https://framablog.org/feed/" foss framasoft text)
	  ("https://www.koumbit.org/en/rss.xml" foss kombit text)
	  ("https://distrowatch.com/news/dww.xml" foss distro text)

	  ("https://guix.gnu.org/feeds/blog.atom" foss guix text)
	  ("https://www.sciencedaily.com/rss/top/science.xml" science text)
	  ("https://www.sciencedaily.com/rss/plants_animals/evolution.xml" science evolution text)
	  ("https://www.sciencedaily.com/rss/plants_animals/molecular_biology.xml" science molecular text)
	  ("https://www.sciencedaily.com/rss/plants_animals/microbiology.xml" science microbiology text)
	  ("https://www.sciencedaily.com/rss/plants_animals/viruses.xml" science microbiology virus text)
	  ("https://www.sciencedaily.com/rss/plants_animals/bacteria.xml" science microbiology bacteria text)
	  ))
  )

(use-package elfeed-summary
  :general
  (k8x1d/leader-keys
    "o" '(:ignore t :which-key "Open")
    "oR" '(elfeed-summary :which-key "RSS Feed")
    )
  :bind
  ("C-c o R" . elfeed-summary)
  :config
  (setq elfeed-summary-settings 
	'(;;(group (:title . "All feeds") (:elements (query . :all)))
	  (group (:title . "News") (:elements (query . news)))
	  (group (:title . "Videos") (:elements (query . video)))
	  (group (:title . "Science") (:elements (query . science)))
	  (group (:title . "FOSS") (:elements (query . foss)))
	  (group (:title . "Searches")
		 (:elements
		  (search (:filter . "@7-days-ago +unread")
			  (:title . "Unread entries this week"))
		  (search (:filter . "@6-months-ago emacs")
			  (:title . "Something about Emacs"))))))
  )

(provide 'rss-module)
