#|
Copyright (c) 2015 Masaya TANIGUCHI (ta2gch@gmail.com)

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
|#

(in-package :cl-user)
(defpackage ufo
  (:use :cl :ufo.install :ufo.util)
  (:export ufo))
(in-package :ufo)

(defun ufo/install (uri)
  (handler-case
      (multiple-value-bind
	    (scheme path) (parse-uri uri)
	(cond ((string= scheme "gist")
	       (install-gist path))
	      ((string= scheme "file")
	       (install-file path))
	      ((string= scheme "http")
	       (install-http path))
	      ((string= scheme "https")
	       (install-https path))))
    (dex:http-request-failed ()
      (format *error-output* "not-found: ~a~%" path))
    (error (e) (format *error-output* "~a~%" e))))

(defun ufo/remove (name)
  (uiop:delete-file-if-exists (r name)))

(defun ufo/update (url)
  (ufo/install url))

(defun ufo (&key (install nil install-supplied-p)
	      (remove nil remove-supplied-p)
	      (update nil update-supplied-p))
    (cond (install-supplied-p
	   (ufo/install install))
	  (remove-supplied-p
	   (ufo/remove remove))
	  (update-supplied-p
	   (ufo/update update))))

#+ros.installing
(eval-when (:compile-toplevel :load-toplevel :execute)
  (setq ros.install:*build-hook*
	(lambda ()
	  (ros:roswell
	   `("build"
	     ,(merge-pathnames "ufo.ros" (ql:where-is-system "ufo"))
	     "-o"
	     ,(ensure-directories-exist
	       (merge-pathnames
		"roswell/ufo"
		(ql:where-is-system "ufo"))))
	   :interactive nil))))
