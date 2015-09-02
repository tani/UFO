(in-package #:cl-user)
(defpackage ufo.addon
  (:use :cl :uiop :ufo.util)
  (:export :addon))
(in-package #:ufo.addon)

(defun addon (&rest argv)
  (let* ((ros (first argv))
	 (out (merge-pathnames (pathname-name ros) (dot-ufo #p"addon/"))))
    (unless (probe-file out)
      (run-program `("ros" "build",(namestring ros)"-o",(namestring out))
		   :output t :error-output t))))
