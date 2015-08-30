(in-package #:cl-user)
(defpackage ufo.addon
  (:use :cl :ufo.util)
  (:export :addon))
(in-package #:ufo.addon)

(defun addon (&rest argv)
  (let* ((ros (first argv))
	 (out (merge-pathnames(pathname-name ros)(ufo.util:dot-ufo #p"addon/"))))
    (unless (probe-file out)(ros:roswell`("build",ros"-o",out):interactive nil))))
