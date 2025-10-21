run:
	/home/nandi/.local/share/mise/installs/sbcl/2.5.9/bin/sbcl --eval "(load \"/home/nandi/quicklisp/setup.lisp\")" --eval "(ql:quickload :hunchentoot)" --eval "(ql:quickload :ironclad)" --eval "(require :asdf)" --eval "(asdf:load-asd \"$(pwd)/sbcl-project/sbcl-project.asd\")" --eval "(asdf:load-system :sbcl-project)" --eval "(handler-case (sbcl-project:main) (error (e) (format t \"Error: ~a~%\" e)))" --quit

repl:
	/home/nandi/.local/share/mise/installs/sbcl/2.5.9/bin/sbcl --eval "(load \"/home/nandi/quicklisp/setup.lisp\")" --eval "(ql:quickload :hunchentoot)" --eval "(ql:quickload :ironclad)" --eval "(require :asdf)" --eval "(asdf:load-asd \"$(pwd)/ecl-project.asd\")" --eval "(asdf:load-system :ecl-project)"

factorial n:
	/home/nandi/.local/share/mise/installs/sbcl/2.5.9/bin/sbcl --eval "(load \"/home/nandi/quicklisp/setup.lisp\")" --eval "(ql:quickload :hunchentoot)" --eval "(ql:quickload :ironclad)" --eval "(require :asdf)" --eval "(asdf:load-asd \"$(pwd)/ecl-project.asd\")" --eval "(asdf:load-system :ecl-project)" --eval "(format t \"Factorial of {{n}} is ~a~%\" (ecl-project:factorial {{n}}))" --quit

build-server:
	mkdir -p bin && sbcl --eval "(sb-ext:disable-debugger)" --eval "(load \"/home/nandi/quicklisp/setup.lisp\")" --eval "(ql:quickload :hunchentoot)" --eval "(require :asdf)" --eval "(asdf:load-asd \"$(pwd)/server.asd\")" --eval "(asdf:operate 'asdf:program-op :server)"

build-keys:
	mkdir -p bin && sbcl --eval "(sb-ext:disable-debugger)" --eval "(load \"/home/nandi/quicklisp/setup.lisp\")" --eval "(ql:quickload :ironclad)" --eval "(ql:quickload :bordeaux-threads)" --eval "(require :asdf)" --eval "(asdf:load-asd \"$(pwd)/keys.asd\")" --eval "(asdf:operate 'asdf:program-op :keys)"

build-churn:
	mkdir -p bin && sbcl --eval "(sb-ext:disable-debugger)" --eval "(load \"/home/nandi/quicklisp/setup.lisp\")" --eval "(ql:quickload :ironclad)" --eval "(ql:quickload :bordeaux-threads)" --eval "(require :asdf)" --eval "(asdf:load-asd \"$(pwd)/churn.asd\")" --eval "(asdf:operate 'asdf:program-op :churn)"

build-brot:
	mkdir -p bin && sbcl --eval "(sb-ext:disable-debugger)" --eval "(load \"/home/nandi/quicklisp/setup.lisp\")" --eval "(require :asdf)" --eval "(asdf:load-asd \"$(pwd)/brot.asd\")" --eval "(asdf:operate 'asdf:program-op :brot)"
