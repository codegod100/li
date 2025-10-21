(load "/home/nandi/quicklisp/setup.lisp")

(defsystem "churn"
  :description "Churn build for ECL project"
  :author "Your Name"
  :license "MIT"
  :version "0.1.0"
  :serial t
  :depends-on (:ironclad :bordeaux-threads)
  :build-operation "program-op"
  :build-pathname "bin/churn"
  :entry-point "churn:main-churn"
  :components ((:module "src"
                :components ((:file "churn")))))
