

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

(defun factorial (n)
  (if (<= n 1)
      1
      (* n (factorial (- n 1)))))

(defun start-server ()
  (hunchentoot:define-easy-handler (hello-handler :uri "/") ()
    (setf (hunchentoot:content-type*) "text/html")
    (or (read-file-into-string "static/index.html")
        "<html><body><h1>Welcome to the ECL Server</h1><p>Static file not found.</p></body></html>"))
  (hunchentoot:define-easy-handler (factorial-handler :uri "/factorial") (n)
    (setf (hunchentoot:content-type*) "application/json")
    (let ((num (parse-integer n :junk-allowed t)))
      (if (and num (>= num 0))
          (format nil "{\"number\": ~a, \"result\": ~a}" num (factorial num))
          "{\"error\": \"Invalid input\"}")))
  (format t "Starting ECL web server on port 8080...~%")
  (handler-case
      (progn
        (hunchentoot:start (make-instance 'hunchentoot:easy-acceptor :port 8080))
        (format t "Server is running. Visit http://localhost:8080 in your browser.~%")
        (format t "Press Ctrl+C to stop the server.~%")
        (loop (sleep 1)))
    (error (e)
      (format t "Failed to start server: ~a~%" e)
      (sb-ext:exit :code 1))))
