(load "/home/nandi/quicklisp/setup.lisp")

(defsystem "ecl-project"
  :description "An ECL project for key generation and CPU churning"
  :author "Your Name"
  :license "MIT"
  :version "0.1.0"
  :serial t
  :depends-on (:hunchentoot :ironclad :bordeaux-threads)
  :build-operation "program-op"
:build-pathname "bin/server"
:entry-point "ecl-project:start-server"
  :components ((:module "src"
                :components ((:file "server")))))
