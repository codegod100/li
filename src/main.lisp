(defpackage :sbcl-project
  (:use :cl :ironclad :bordeaux-threads)
  (:export :main :start-server :generate-curve25519-key :generate-keys-multi-threaded))

(in-package :sbcl-project)

(defparameter *num-threads* 4)



#|
(defun hello ()
  (format t "Hello, World!~%"))
|#

#|
(defun factorial (n)
  (if (<= n 1)
      1
      (* n (factorial (- n 1)))))
|#

(defun generate-curve25519-key ()
  (let ((priv-key (ironclad:generate-key-pair :curve25519)))
    (let ((priv-octets (ironclad:curve25519-key-x priv-key))
          (pub-octets (ironclad:curve25519-public-key (ironclad:curve25519-key-x priv-key))))
      (format t "Private key: ~a~%" (ironclad:byte-array-to-hex-string priv-octets))
      (format t "Public key: ~a~%" (ironclad:byte-array-to-hex-string pub-octets))
      (values priv-octets pub-octets))))

(defun generate-keys-multi-threaded (num-keys)
 (let ((results (make-array num-keys :initial-element nil))
       (threads '()))
   (dotimes (i num-keys)
     (let ((index i))
       (push (bt:make-thread
              (lambda ()
                (let ((key-pair (generate-curve25519-key)))
                  (setf (aref results index) key-pair))))
             threads)))
   (mapc #'bt:join-thread threads)
   (format t "Generated ~a key pairs using ~a threads.~%" num-keys *num-threads*)
   results))

(defun churn-threads (num-threads)
  (let ((threads '()))
    (dotimes (i num-threads)
      (push (bt:make-thread
             (lambda ()
               (loop
                 (dotimes (j 10000000)
                   (sqrt (float j))
                   (sin (float j))
                   (cos (float j))))))
            threads))
    (mapc #'bt:join-thread threads)))

#|
(defun read-file-into-string (path)
  (with-open-file (stream path :direction :input :if-does-not-exist nil)
    (when stream
      (let ((contents (make-string (file-length stream))))
        (read-sequence contents stream)
        contents))))
|#

(defun main ()
  #|(hello)
  (format t "Factorial of 5 is ~a~%" (factorial 5))|#
  (generate-curve25519-key)
  (generate-keys-multi-threaded 4))

(defun main-churn ()
  (churn-threads 16))

#|
(hunchentoot:define-easy-handler (factorial-handler :uri "/factorial") (n)
  (let ((num (parse-integer n :junk-allowed t)))
    (if (string= (hunchentoot:header-in* "X-Requested-With") "XMLHttpRequest")
        ;; AJAX request: return JSON
        (progn
          (setf (hunchentoot:content-type*) "application/json")
          (if num
              (format nil "{\"number\": ~a, \"result\": ~a}" num (factorial num))
              "{\"error\": \"Invalid number\"}"))
        ;; Direct request: return HTML
        (progn
          (setf (hunchentoot:content-type*) "text/html")
          (if num
              (format nil "<html><head><title>Factorial Result</title></head><body><h1>Factorial of ~a is ~a</h1><a href='/'>Back</a></body></html>" num (factorial num))
              "<html><head><title>Error</title></head><body><h1>Invalid number</h1><a href='/'>Back</a></body></html>")))))

(hunchentoot:define-easy-handler (hello-handler :uri "/") ()
  (setf (hunchentoot:content-type*) "text/html")
  (read-file-into-string (merge-pathnames "static/index.html" (asdf:system-source-directory :sbcl-project))))

#|
(defun start-server ()
  (hunchentoot:start (make-instance 'hunchentoot:easy-acceptor :port 8080)))
|#
|#

(main-churn)
(ext:quit)
