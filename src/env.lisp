(in-package #:cl-user)
(defpackage ufo.env
  (:use :cl)
  (:export :dot-ufo :dot-roswell))
(in-package #:ufo.env)

(defun dot-ufo (path)
  (merge-pathnames
   path (merge-pathnames #p".ufo/" (user-homedir-pathname))))
(defun dot-roswell (path)
  (merge-pathnames
   path (merge-pathnames #p".roswell/" (user-homedir-pathname))))
