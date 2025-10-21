<file_path>
li/src/brot.lisp
</file_path>

<edit_description>
Create brot.lisp with Mandelbrot drawing code
</edit_description>

(defpackage :ecl-project
  (:use :cl)
  (:export :main-brot))

(in-package :ecl-project)

(defun mandelbrot-iterations (c max-iter)
  (let ((z #C(0.0 0.0)))
    (dotimes (i max-iter)
      (setf z (+ (* z z) c))
      (when (> (abs z) 2.0)
        (return (1+ i))))
    0))

(defun draw-mandelbrot (width height)
  (let ((x-min -2.5) (x-max 1.0)
        (y-min -1.0) (y-max 1.0))
    (dotimes (y height)
      (dotimes (x width)
        (let* ((real-part (+ x-min (* (/ x (float width)) (- x-max x-min))))
               (imag-part (- y-max (* (/ y (float height)) (- y-max y-min))))
               (c (complex real-part imag-part))
               (iter (mandelbrot-iterations c 100)))
          (cond ((= iter 0) (princ #\#))
                ((> iter 50) (princ #\*))
                ((> iter 20) (princ #\+))
                (t (princ #\ )))))
      (terpri))))

(defun main-brot ()
  (draw-mandelbrot 80 24))
