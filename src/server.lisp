

(defpackage :ecl-project
  (:use :cl :ironclad :bordeaux-threads)
  (:export :start-server :main :generate-curve25519-key :generate-keys-multi-threaded :main-churn :churn-threads))

(in-package :ecl-project)

(defun read-file-into-string (path)
  (with-open-file (stream path :direction :input :if-does-not-exist nil)
    (when stream
      (let ((contents (make-string (file-length stream))))
        (read-sequence contents stream)
        contents))))

(defun start-server ()
  (hunchentoot:define-easy-handler (hello-handler :uri "/") ()
    (setf (hunchentoot:content-type*) "text/html")
    (or (read-file-into-string "static/index.html")
        "<html><body><h1>Welcome to the ECL Server</h1><p>Static file not found.</p></body></html>"))
  (format t "Starting ECL web server on port 8080...~%")
  (format t "Server is running. Visit http://localhost:8080 in your browser.~%")
  (format t "Press Ctrl+C to stop the server.~%")
  (hunchentoot:start (make-instance 'hunchentoot:easy-acceptor :port 8080)))
