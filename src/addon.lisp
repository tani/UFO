(in-package #:cl-user)
(defpackage ufo.addon
  (:use :cl :ufo.env)
  (:export :addon))
(in-package #:ufo.addon)

(defun addon (&rest argv)
  (declare (ignorable argv))
  (let* ((ros (first argv))
	 (out (merge-pathnames
	       (pathname-name ros)
	       (ufo.env:dot-ufo #p"addon/"))))
    (ignore-errors
     (ros:roswell `("build" ,ros "-o" ,out) :interactive nil))))
