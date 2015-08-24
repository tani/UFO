(in-package :cl)
(defpackage ufo.build
  (:use :cl)
  (:export build))
(in-package :ufo.build)

(ql:quickload '(:uiop :cl-fad))

(defun build-1 (in tmp path &optional roswell-script-p)
  (when roswell-script-p (read-line in nil nil))
  (loop :for l := (read-line in nil nil) :while l :do
    (format tmp "~a~%" l))
  (format tmp
"(sb-ext:save-lisp-and-die \"~a\" 
:executable t 
:toplevel (lambda () (apply #'main (rest sb-ext:*posix-argv*))))~%"
(pathname-name path)))

(defun build (path)
  (let ((src (cl-fad:with-output-to-temporary-file (tmp)
	       (with-open-file (in path)
		 (build-1 in tmp path t)))))
    (uiop:run-program (list "ros" "-l" (namestring src) "-q"))
    (delete-file src)))
