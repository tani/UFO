#|
  This file is a part of ufo project.
  Copyright (c) 2015 Masaya TANIGUCHI (ta2gch@gmail.com)
|#

#|
  Roswell Script Installer

  Author: Masaya TANIGUCHI (ta2gch@gmail.com)
|#

(in-package :cl-user)
(defpackage ufo-asd
  (:use :cl :asdf))
(in-package :ufo-asd)

(defsystem ufo
  :version "0.1"
  :author "Masaya TANIGUCHI"
  :license "MIT"
  :depends-on (:cl-ppcre
               :cl-gists
               :dexador)
  :components ((:module "src"
                :components
                ((:file "ufo"))))
  :description "Roswell Script Installer"
  :long-description
  #.(with-open-file (stream (merge-pathnames
                             #p"README.markdown"
                             (or *load-pathname* *compile-file-pathname*))
                            :if-does-not-exist nil
                            :direction :input)
      (when stream
        (let ((seq (make-array (file-length stream)
                               :element-type 'character
                               :fill-pointer t)))
          (setf (fill-pointer seq) (read-sequence seq stream))
          seq)))
  :in-order-to ((test-op (test-op ufo-test))))
