(in-package :cl)

(defpackage ufo.install
  (:use :cl :ufo.util :ufo.build)
  (:export install-http
	   install-https
	   install-gist
	   install-file))
(in-package :ufo.install)

(ql:quickload
 '(#-ros.init :dexador
   :uiop
   :cl-gists))

(defun download (url dist)
  #+ros.init
  (ros:roswell
   `("roswell-internal-use" "download" ,url ,dist)
   :interactive nil)
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
  (let ((url (format nil "http://~a" (namestring path)))
	(txt (tmp (file-namestring path))))
    (download url txt)
    (build txt)
    (format t "~a -> ~a~%" (pathname-name txt) (r (pathname-name txt)))
    (rename-file (pathname-name txt) (r (pathname-name txt)))
    (uiop:delete-file-if-exists txt)))

(defun install-https (path)
  (setq path (pathname path))
  (let ((url (format nil "https://~a" (namestring path)))
	(txt (tmp (file-namestring path))))
    (download url txt)
    (build txt)
    (format t "~a -> ~a~%" (pathname-name txt) (r (pathname-name txt)))
    (rename-file (pathname-name txt) (r (pathname-name txt)))
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
  (error "not found: ~a" path))

(defun install-file (path)
  (unless (probe-file path)
    (error "not found: ~a" path))
  (build (pathname path))
  (format t "~a -> ~a~%" (pathname-name path) (r (pathname-name path)))
  (rename-file (pathname-name path) (r (pathname-name path))))
