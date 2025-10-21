(defpackage :churn
  (:use :cl :ironclad :bordeaux-threads)
  (:export :main-churn :churn-threads))

(in-package :churn)

(defparameter *num-threads* 4)

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

(defun main-churn ()
  (churn-threads 16))
