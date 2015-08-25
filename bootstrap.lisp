(load #p"ufo.asd")
(ql:quickload :ufo)
(defun main (argv)
  (unless (= 3 (length argv))
    (format *error-output* "invalid argument: ~{~a~}~%" argv)
    (sb-ext:exit))
  (let ((op (second argv)) (uri (third argv)))
    (cond ((string= "install" op)
	   (ufo:ufo :install uri))
	  ((string= "remove" op)
	   (ufo:ufo :remove  uri))
	  ((string= "update" op)
	   (ufo:ufo :update uri)))))
(sb-ext:save-lisp-and-die
 "ufo"
 :toplevel (lambda ()
	     (main sb-ext:*posix-argv*))
 :executable t)
