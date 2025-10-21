run:
	/home/nandi/.local/share/mise/installs/sbcl/2.5.9/bin/sbcl --eval "(load \"/home/nandi/quicklisp/setup.lisp\")" --eval "(ql:quickload :hunchentoot)" --eval "(ql:quickload :ironclad)" --eval "(require :asdf)" --eval "(asdf:load-asd \"$(pwd)/sbcl-project/sbcl-project.asd\")" --eval "(asdf:load-system :sbcl-project)" --eval "(handler-case (sbcl-project:main) (error (e) (format t \"Error: ~a~%\" e)))" --quit

repl:
	/home/nandi/.local/share/mise/installs/sbcl/2.5.9/bin/sbcl --eval "(load \"/home/nandi/quicklisp/setup.lisp\")" --eval "(ql:quickload :hunchentoot)" --eval "(ql:quickload :ironclad)" --eval "(require :asdf)" --eval "(asdf:load-asd \"$(pwd)/ecl-project.asd\")" --eval "(asdf:load-system :ecl-project)"

factorial n:
	/home/nandi/.local/share/mise/installs/sbcl/2.5.9/bin/sbcl --eval "(load \"/home/nandi/quicklisp/setup.lisp\")" --eval "(ql:quickload :hunchentoot)" --eval "(ql:quickload :ironclad)" --eval "(require :asdf)" --eval "(asdf:load-asd \"$(pwd)/ecl-project.asd\")" --eval "(asdf:load-system :ecl-project)" --eval "(format t \"Factorial of {{n}} is ~a~%\" (ecl-project:factorial {{n}}))" --quit

serve:
	/home/nandi/.local/share/mise/installs/sbcl/2.5.9/bin/sbcl --eval "(load \"/home/nandi/quicklisp/setup.lisp\")" --eval "(ql:quickload :hunchentoot)" --eval "(ql:quickload :ironclad)" --eval "(require :asdf)" --eval "(asdf:load-asd \"$(pwd)/ecl-project.asd\")" --eval "(asdf:load-system :ecl-project)" --eval "(ecl-project:start-server)"

build-keys:
	mkdir -p bin && sed -i '/:build-pathname/c\:build-pathname "bin/keys"' ecl-project.asd && sed -i '/:entry-point/c\:entry-point "ecl-project:main"' ecl-project.asd && sed -i 's/churn/keygen/' ecl-project.asd && sed -i 's/(main-churn)/(main)/' src/keygen.lisp && /usr/bin/ecl -eval "(load \"/home/nandi/quicklisp/setup.lisp\")" -eval "(ql:quickload :ironclad)" -eval "(ql:quickload :bordeaux-threads)" -eval "(require :asdf)" -eval "(asdf:load-asd \"$(pwd)/ecl-project.asd\")" -eval "(asdf:make :ecl-project)" -eval "(ext:quit)"

build-churn:
	mkdir -p bin && sed -i 's/keygen/churn/' ecl-project.asd && sed -i '/:build-pathname/c\:build-pathname "bin/churn"' ecl-project.asd && sed -i '/:entry-point/c\:entry-point "ecl-project:main-churn"' ecl-project.asd && sed -i 's/(main)/(main-churn)/' src/churn.lisp && /usr/bin/ecl -eval "(load \"/home/nandi/quicklisp/setup.lisp\")" -eval "(ql:quickload :ironclad)" -eval "(ql:quickload :bordeaux-threads)" -eval "(require :asdf)" -eval "(asdf:load-asd \"$(pwd)/ecl-project.asd\")" -eval "(asdf:make :ecl-project)" -eval "(ext:quit)"
