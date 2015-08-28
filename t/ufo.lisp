(in-package :cl-user)
(defpackage ufo-test
  (:use :cl :ufo :prove))
(in-package :ufo-test)

(plan nil)

(ok (not (ufo:ufo "install" "gist://ta2gch/repl.ros")))
(ok (not (ufo:ufo "install" "ql://cl-gists")))
(ok (not (ufo:ufo "remove" "repl")))
(ok (not (ufo:ufo "update" "gist://ta2gch/repl.ros")))
(ok (not (ufo:ufo "install" "gh://ta2gch/cl-pov")))
(ok (not (ufo:ufo "addon-install"
		  (format nil "file://~a"
			  (merge-pathnames
			   #p"addon/extension/build.ros"
			   (ql:where-is-system :ufo))))))
(ok (not (ufo:ufo "addon-remove" "build")))
(ok (not (ufo:ufo "help")))

(ok (ufo:ufo "install" "gist://ta2gch/repl"))
(ok (ufo:ufo "install" "file://ta2gch/repl"))
(ok (ufo:ufo "update" "http://ta2gch/repl"))
(ok (ufo:ufo "addon-install"
	     (format nil "file://~a"
		     (merge-pathnames
		      #p"addon/extension/build"
		      (ql:where-is-system :ufo)))))

(finalize)
