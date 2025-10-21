(load "/home/nandi/quicklisp/setup.lisp")

(defsystem "server"
  :description "Server build for ECL project"
  :author "Your Name"
  :license "MIT"
  :version "0.1.0"
  :serial t
  :depends-on (:hunchentoot)
  :build-operation "program-op"
  :build-pathname "bin/server"
  :entry-point "ecl-project:start-server"
  :components ((:module "src"
                :components ((:file "server")))))
