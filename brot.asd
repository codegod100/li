(load "/home/nandi/quicklisp/setup.lisp")

(defsystem "brot"
  :description "Brot build for ECL project"
  :author "Your Name"
  :license "MIT"
  :version "0.1.0"
  :serial t
  :depends-on ()
  :build-operation "program-op"
  :build-pathname "bin/brot"
  :entry-point "brot:main-brot"
  :components ((:module "src"
                :components ((:file "brot")))))
