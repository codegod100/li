run:
	/home/nandi/.local/share/mise/installs/sbcl/2.5.9/bin/sbcl --eval "(load \"/home/nandi/quicklisp/setup.lisp\")" --eval "(ql:quickload :hunchentoot)" --eval "(ql:quickload :ironclad)" --eval "(require :asdf)" --eval "(asdf:load-asd \"$(pwd)/sbcl-project/sbcl-project.asd\")" --eval "(asdf:load-system :sbcl-project)" --eval "(handler-case (sbcl-project:main) (error (e) (format t \"Error: ~a~%\" e)))" --quit

repl:
	/home/nandi/.local/share/mise/installs/sbcl/2.5.9/bin/sbcl --eval "(load \"/home/nandi/quicklisp/setup.lisp\")" --eval "(ql:quickload :hunchentoot)" --eval "(ql:quickload :ironclad)" --eval "(require :asdf)" --eval "(asdf:load-asd \"$(pwd)/ecl-project.asd\")" --eval "(asdf:load-system :ecl-project)"

factorial n:
	/home/nandi/.local/share/mise/installs/sbcl/2.5.9/bin/sbcl --eval "(load \"/home/nandi/quicklisp/setup.lisp\")" --eval "(ql:quickload :hunchentoot)" --eval "(ql:quickload :ironclad)" --eval "(require :asdf)" --eval "(asdf:load-asd \"$(pwd)/ecl-project.asd\")" --eval "(asdf:load-system :ecl-project)" --eval "(format t \"Factorial of {{n}} is ~a~%\" (ecl-project:factorial {{n}}))" --quit

build-server:
	mkdir -p bin && sbcl --eval "(sb-ext:disable-debugger)" --eval "(load \"/home/nandi/quicklisp/setup.lisp\")" --eval "(ql:quickload :hunchentoot)" --eval "(require :asdf)" --eval "(asdf:load-asd \"$(pwd)/server.asd\")" --eval "(asdf:load-system :server)" --eval "(sb-ext:save-lisp-and-die \"bin/server\" :executable t :toplevel #'server:start-server :compression t)"

build-keys:
	mkdir -p bin && sbcl --eval "(sb-ext:disable-debugger)" --eval "(load \"/home/nandi/quicklisp/setup.lisp\")" --eval "(ql:quickload :ironclad)" --eval "(ql:quickload :bordeaux-threads)" --eval "(require :asdf)" --eval "(asdf:load-asd \"$(pwd)/keys.asd\")" --eval "(asdf:load-system :keys)" --eval "(sb-ext:save-lisp-and-die \"bin/keys\" :executable t :toplevel #'keys:main :compression t)"

build-churn:
	mkdir -p bin && sbcl --eval "(sb-ext:disable-debugger)" --eval "(load \"/home/nandi/quicklisp/setup.lisp\")" --eval "(ql:quickload :ironclad)" --eval "(ql:quickload :bordeaux-threads)" --eval "(require :asdf)" --eval "(asdf:load-asd \"$(pwd)/churn.asd\")" --eval "(asdf:load-system :churn)" --eval "(sb-ext:save-lisp-and-die \"bin/churn\" :executable t :toplevel #'churn:main-churn :compression t)"

build-brot:
	mkdir -p bin && sbcl --eval "(sb-ext:disable-debugger)" --eval "(load \"/home/nandi/quicklisp/setup.lisp\")" --eval "(require :asdf)" --eval "(asdf:load-asd \"$(pwd)/brot.asd\")" --eval "(asdf:load-system :brot)" --eval "(sb-ext:save-lisp-and-die \"bin/brot\" :executable t :toplevel #'brot:main-brot :compression t)"
