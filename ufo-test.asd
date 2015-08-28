#|
  This file is a part of UFO project.
  Copyright (c) 2015 Masaya TANIGUCHI (ta2gch@gmail.com)
|#

(in-package :cl-user)
(defpackage ufo-test-asd
  (:use :cl :asdf))
(in-package :ufo-test-asd)

(defsystem ufo-test
  :author "Masaya TANIGUCHI"
  :license "GPLv3"
  :depends-on (:ufo
               :prove)
  :components ((:module "t"
                :components
                ((:test-file "ufo"))))
  :description "UFO is Roswell Script Installer"
  :defsystem-depends-on (:prove-asdf)
  :perform (test-op :after (op c)
                    (funcall (intern #.(string :run-test-system) :prove-asdf) c)
                    (asdf:clear-system c)))
