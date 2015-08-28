(in-package #:cl-user)
(defpackage ufo.util
  (:use :cl)
  (:export :dot-ufo :dot-roswell :download))
(in-package #:ufo.util)

(defun dot-ufo (path)
  (merge-pathnames
   path (merge-pathnames #p".ufo/" (user-homedir-pathname))))
(defun dot-roswell (path)
  (merge-pathnames
   path (merge-pathnames #p".roswell/" (user-homedir-pathname))))

(defun download (url dist)
  (with-open-file (file dist
 			:direction :io
 			:if-does-not-exist :create
 			:if-exists :supersede
 			:element-type '(unsigned-byte 8))
     (let ((input (dex:get url :want-stream t :force-binary t)))
       (do ((byte (read-byte input nil nil) (read-byte input nil nil)))
 	  ((not byte))
 	(write-byte byte file)))))
