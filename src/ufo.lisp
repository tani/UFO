(in-package #:cl-user)
(defpackage ufo
  (:use :cl :uiop :ufo.util :ufo.addon)
  (:export :ufo :setup :dot-ufo :dot-roswell))
(in-package #:ufo)

(defun subcmd-p (subcmd)
  (let* ((ros (make-pathname :name subcmd))
	 (cmd-path (merge-pathnames ros (ufo.util:dot-ufo #p"addon/"))))
    (if (probe-file cmd-path) cmd-path nil)))

(defun setup ()
  (ensure-directories-exist (ufo.util:dot-ufo #p"addon/"))
  (ensure-directories-exist (ufo.util:dot-ufo #p"tmp/"))
  (let ((addon-dir(merge-pathnames "addon/"(ql:where-is-system :ufo))))
    (dolist (addon '("addon-install.ros" "addon-remove.ros"
		     "install.ros" "remove.ros" "update.ros" "help.ros"))
      (ufo.addon:addon(merge-pathnames addon addon-dir)))))

(defun ufo (subcmd &rest argv)
  (setup)
  (handler-case 
      (let ((cmd (subcmd-p subcmd)))
	(if cmd
	    (run-program (cons cmd argv)
	     :output t :error-output *error-output*)
	    (progn (princ "unkown subcommand") t)))
    (error (e) (princ e) (terpri) t)))
  
