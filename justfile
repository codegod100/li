run:
	/home/nandi/.local/share/mise/installs/sbcl/2.5.9/bin/sbcl --eval "(load \"/home/nandi/quicklisp/setup.lisp\")" --eval "(ql:quickload :hunchentoot)" --eval "(ql:quickload :ironclad)" --eval "(require :asdf)" --eval "(asdf:load-asd \"$(pwd)/sbcl-project/sbcl-project.asd\")" --eval "(asdf:load-system :sbcl-project)" --eval "(handler-case (sbcl-project:main) (error (e) (format t \"Error: ~a~%\" e)))" --quit

repl:
	/home/nandi/.local/share/mise/installs/sbcl/2.5.9/bin/sbcl --eval "(load \"/home/nandi/quicklisp/setup.lisp\")" --eval "(ql:quickload :hunchentoot)" --eval "(ql:quickload :ironclad)" --eval "(require :asdf)" --eval "(asdf:load-asd \"$(pwd)/ecl-project.asd\")" --eval "(asdf:load-system :ecl-project)"

factorial n:
	/home/nandi/.local/share/mise/installs/sbcl/2.5.9/bin/sbcl --eval "(load \"/home/nandi/quicklisp/setup.lisp\")" --eval "(ql:quickload :hunchentoot)" --eval "(ql:quickload :ironclad)" --eval "(require :asdf)" --eval "(asdf:load-asd \"$(pwd)/ecl-project.asd\")" --eval "(asdf:load-system :ecl-project)" --eval "(format t \"Factorial of {{n}} is ~a~%\" (ecl-project:factorial {{n}}))" --quit

build-server:
	mkdir -p bin && sed -i '/:build-pathname/c\:build-pathname "bin/server"' ecl-project.asd && sed -i '/:entry-point/c\:entry-point "ecl-project:start-server"' ecl-project.asd && sed -i 's/(:file "[^"]*")/(:file "server")/' ecl-project.asd && sbcl --eval "(sb-ext:disable-debugger)" --eval "(load \"/home/nandi/quicklisp/setup.lisp\")" --eval "(ql:quickload :hunchentoot)" --eval "(ql:quickload :ironclad)" --eval "(ql:quickload :bordeaux-threads)" --eval "(require :asdf)" --eval "(asdf:load-asd \"$(pwd)/ecl-project.asd\")" --eval "(asdf:load-system :ecl-project)" --eval "(sb-ext:save-lisp-and-die \"bin/server\" :executable t :toplevel 'ecl-project:start-server)"

build-keys:
	mkdir -p bin && sed -i '/:build-pathname/c\:build-pathname "bin/keys"' ecl-project.asd && sed -i '/:entry-point/c\:entry-point "ecl-project:main"' ecl-project.asd && sed -i 's/(:file "[^"]*")/(:file "keys")/' ecl-project.asd && sbcl --eval "(sb-ext:disable-debugger)" --eval "(load \"/home/nandi/quicklisp/setup.lisp\")" --eval "(ql:quickload :ironclad)" --eval "(ql:quickload :bordeaux-threads)" --eval "(require :asdf)" --eval "(asdf:load-asd \"$(pwd)/ecl-project.asd\")" --eval "(asdf:load-system :ecl-project)" --eval "(sb-ext:save-lisp-and-die \"bin/keys\" :executable t :toplevel 'ecl-project:main)"

build-churn:
	mkdir -p bin && sed -i 's/(:file "[^"]*")/(:file "churn")/' ecl-project.asd && sed -i '/:build-pathname/c\:build-pathname "bin/churn"' ecl-project.asd && sed -i '/:entry-point/c\:entry-point "ecl-project:main-churn"' ecl-project.asd && sbcl --eval "(sb-ext:disable-debugger)" --eval "(load \"/home/nandi/quicklisp/setup.lisp\")" --eval "(ql:quickload :ironclad)" --eval "(ql:quickload :bordeaux-threads)" --eval "(require :asdf)" --eval "(asdf:load-asd \"$(pwd)/ecl-project.asd\")" --eval "(asdf:load-system :ecl-project)" --eval "(sb-ext:save-lisp-and-die \"bin/churn\" :executable t :toplevel 'ecl-project:main-churn)"
