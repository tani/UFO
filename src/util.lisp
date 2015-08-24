(in-package :cl)
(defpackage ufo.util
  (:use :cl :cl-ppcre)
  (:export e r tmp parse-uri))
(in-package :ufo.util)

(defvar *bin-install-base-path* (user-homedir-pathname))

(defun e (&optional (p ""))
  (merge-pathnames (pathname-name p) (directory-namestring p)))
(defun r (&optional (p ""))
  (format nil "~A" (merge-pathnames p (merge-pathnames ".roswell/bin/" *bin-install-base-path*))))
(defun tmp (&optional (p ""))
  (format nil "~A" (merge-pathnames p (merge-pathnames ".roswell/tmp/" (or *bin-install-base-path*)))))

(defun parse-uri (uri)
  (multiple-value-call
      (lambda (fst scnd)
	(declare (ignore fst))
	(values (elt scnd 0) (elt scnd 1)))
    (if (ppcre:scan "^(gist|file|https?)://." uri)
	(ppcre:scan-to-strings
	 "^(gist|file|https?)://(.+)$" uri)
	(error "unkown scheme"))))
