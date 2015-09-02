(in-package :cl-user)
(defpackage ufo-test
  (:use :cl :ufo :prove))
(in-package :ufo-test)

(when (cl-fad:directory-exists-p #p"~/.ufo")
  (cl-fad:delete-directory-and-files #p"~/.ufo/"))
(plan nil)

(ok (not (ufo:ufo "install" "gist://fukamachi/clhs.ros")))
(ok (not (ufo:ufo "install" "ql://cl-gists")))
(ok (not (ufo:ufo "remove" "clhs")))
(ok (not (ufo:ufo "update" "gist://fukamachi/clhs.ros")))
(ok (not (ufo:ufo "install" "gh://ta2gch/cl-pov")))
(ok (not (ufo:ufo "addon-install"
		  (format nil "file://~a"
			  (merge-pathnames
			   #p"addon/extension/build.ros"
			   (asdf:system-source-directory :ufo))))))
(ok (not (ufo:ufo "addon-remove" "build")))
(ok (not (ufo:ufo "help")))

(ok (ufo:ufo "unkown"))
(ok (ufo:ufo "install" "ql://ta2gc/aaa"))
(ok (ufo:ufo "install" "g://ta2gch/aaa"))
(ok (ufo:ufo "install" "gh://ta2gch/aaa"))
(ok (ufo:ufo "install" "gist://ta2gch/aaa/bbb"))
(ok (ufo:ufo "install" "gh://aaa"))
(ok (ufo:ufo "install" "gh://"))
(ok (ufo:ufo "install" "gist://ta2gch/aaa"))
(ok (ufo:ufo "install" "file://ta2gch/aaa"))
(ok (ufo:ufo "update" "http://ta2gch/aaa"))
(ok (ufo:ufo "addon-install"
	     (format nil "file://~a"
		     (merge-pathnames
		      #p"addon/extension/aaa"
		      (asdf:system-source-directory :ufo)))))

(finalize)
