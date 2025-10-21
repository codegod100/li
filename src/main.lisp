(defpackage :ecl-project
  (:use :cl :ironclad :bordeaux-threads)
  (:export :main :start-server :generate-curve25519-key :generate-keys-multi-threaded))

(in-package :ecl-project)

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

(defun main ()
  #|(hello)
  (format t "Factorial of 5 is ~a~%" (factorial 5))|#
  (generate-curve25519-key)
  (generate-keys-multi-threaded 4))

(defun main-churn ()
  (churn-threads 16))

(main-churn)
(ext:quit)
