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
  (:use :cl)
  (:export :ufo))
(in-package :ufo)

(ql:quickload
 '(:cl-ppcre
   #-ros.init :dexador
   :uiop
   :cl-gists))

(defvar *bin-install-base-path* (user-homedir-pathname))
(defun r (&optional (p ""))
  (format nil "~A" (merge-pathnames p (merge-pathnames "bin/" (or #+ros.init(ros:opt "homedir") *bin-install-base-path*)))))

(defun parse-uri (uri)
  (multiple-value-call
      (lambda (fst scnd)
	(declare (ignore fst))
	(values (elt scnd 0) (elt scnd 1)))
    (if (ppcre:scan "^(gist|file|https?)://." uri)
	(ppcre:scan-to-strings
	 "^(gist|file|https?)://(.+)$" uri)
	(error (make-instance 'unkown-scheme)))))

(defun download (url dist)
  #+ros.init(ros:roswell `("roswell-internal-use" "download" ,url ,dist) :interactive nil)
  #-ros.init
  (with-open-file (file dist
			:direction :io
			:if-does-not-exist :create
			:if-exists :supersede
			:element-type '(unsigned-byte 8))
    (let ((input (dex:get
		  url
		  :want-stream t
		  :force-binary t)))
      (do ((byte (read-byte input nil nil)
		 (read-byte input nil nil)))
	  ((not byte))
	(write-byte byte file)))))

(defun install-http (path)
  (setq path (pathname path))
  (let ((url (format nil "http://~a" path))
	(txt (make-pathname
	      ;:directory (list :absolute "tmp")
	      :name (pathname-name path)
	      :type (pathname-type path))))
    (download url txt)
    (uiop:run-program
     `("ros" "build" ,(namestring txt)
	     "-o" ,(r (file-namestring txt))))
    (uiop:delete-file-if-exists txt)))

(defun install-https (path)
  (setq path (pathname path))
  (let ((url (format nil "https://~a" (namestring path)))
	(txt (make-pathname
	      ;:directory (list :absolute "tmp")
	      :name (pathname-name path)
	      :type (pathname-type path))))
    (download url txt)
    (uiop:run-program
     `("ros" "build" ,(namestring txt)
	     "-o" ,(r (file-namestring txt))))
    (uiop:delete-file-if-exists txt)))

(defun install-gist (path)
  (setq path (pathname path))
  (dolist (gist (cl-gists:list-gists
		 :username (second (pathname-directory path))))
    (dolist (file (cl-gists:gist-files gist))
      (when (string= (cl-gists:file-name file)
		     (file-namestring path))
	(multiple-value-bind (scheme path)
	    (parse-uri (cl-gists:file-raw-url file))
	  (install-https path))
	(return-from install-gist nil))))
  (error (make-instance 'not-found)))

(defun install-file (path)
  (unless (probe-file path)
    (error (make-instance 'not-found)))
  (uiop:run-program
   `("ros" "build" ,path
	   "-o" ,(r (file-namestring (pathname path))))))

(defun ufo/install (uri)
  (multiple-value-bind
	(scheme path) (parse-uri uri)
    (cond ((string= scheme "gist")
	   (install-gist path))
	  ((string= scheme "file")
	   (install-file path))
	  ((string= scheme "http")
	   (install-http path))
	  ((string= scheme "https")
	   (install-https path)))))

(defun ufo/remove (name)
  (uiop:delete-file-if-exists (r name)))

(defun ufo/update (url)
  (ufo/install url))

(defun ufo (&key
	       (install nil install-supplied-p)
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
		(ql:where-is-system "swank-shell"))))
	   :interactive nil))))
