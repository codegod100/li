(load "/home/nandi/quicklisp/setup.lisp")

(defsystem "keys"
  :description "Keys build for ECL project"
  :author "Your Name"
  :license "MIT"
  :version "0.1.0"
  :serial t
  :depends-on (:ironclad :bordeaux-threads)
  :build-operation "program-op"
  :build-pathname "bin/keys"
  :entry-point "keys:main"
  :components ((:module "src"
                :components ((:file "keys")))))
