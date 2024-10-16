;; -*- lexical-binding: t; -*-

;; Connect to unified calendar
(use-package org-caldav
  :config
  ;; URL of the caldav server
  (setq org-caldav-url "https://nuage.facil.services/remote.php/dav/calendars/k8x1d")
  ;; calendar ID on server
  ;; (setq org-caldav-calendar-id "my-calendar-1")
  ;; Org filename where new entries from calendar stored
  ;; (setq org-caldav-inbox (concat k8x1d/org-directory "/calendars" "/personnel.org"))

  ;; DON'T USE CONSTRUTED PATH, don't work...
  (setq org-caldav-calendars
   	'(
;; https://nuage.facil.services/remote.php/dav/calendars/k8x1d/emploi-1/
	  (:calendar-id "emploi-1"
			;; :files ("~/org/calendars/emplois.org")
			:inbox "~/org/Calendars/emplois.org")
;; https://nuage.facil.services/remote.php/dav/calendars/k8x1d/exercices-1/
	  (:calendar-id "exercices-1"
			;; :files ("~/org/calendars/exercices.org")
			:inbox "~/org/Calendars/exercices.org")
;; https://nuage.facil.services/remote.php/dav/calendars/k8x1d/formation-1/
	  (:calendar-id "formation-1"
			;; :files ("~/org/calendars/formations-extra.org")
			:inbox "~/org/Calendars/formations.org")
;; https://nuage.facil.services/remote.php/dav/calendars/k8x1d/implications-1/
	  (:calendar-id "implications-1"
			;; :files ("~/org/calendars/implications.org")
			:inbox "~/org/Calendars/implications.org")
	  ;; (:calendar-id "my-calendar-1"
			;; :files ("~/org/calendars/personnel.org")
			;; :inbox "~/org/calendars/personnel.org")
;; https://nuage.facil.services/remote.php/dav/calendars/k8x1d/recherche-1/
	  (:calendar-id "recherche-1"
			;; :files ("~/org/calendars/recherches.org")
			:inbox "~/org/Calendars/recherche.org")
			;; :inbox (concat k8x1d/calendars-directory "/recherche.org"))
;; https://nuage.facil.services/remote.php/dav/calendars/k8x1d/social-1/
	  (:calendar-id "social-1"
			;; :files ("~/org/calendars/social.org")
			:inbox "~/org/Calendars/social.org")
;; https://nuage.facil.services/remote.php/dav/calendars/k8x1d/developpements/
	  (:calendar-id "developpements"
			;; :files ("~/org/calendars/social.org")
			:inbox "~/org/Calendars/developpements.org")
	  ))
  (setq org-caldav-save-directory k8x1d/calendars-directory)
  ;; Additional Org files to check for calendar events
  (setq org-caldav-files nil)
  ;; Usually a good idea to set the timezone manually
  (setq org-icalendar-timezone "Europe/Brussels")
  )

(provide 'calendar-module)
