(defpackage :ecl-project
  (:use :cl :ironclad :bordeaux-threads)
  (:export :main-churn :churn-threads))

(in-package :ecl-project)

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
  (ext:set-signal-handler 2 (lambda () (ext:quit)))
  (churn-threads 16))

(main-churn)
(ext:quit)
