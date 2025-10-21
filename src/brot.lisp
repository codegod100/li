(defpackage :brot
  (:use :cl)
  (:export :main-brot))

(in-package :brot)

(defparameter *default-width* 100)
(defparameter *default-height* 40)
(defparameter *default-max-iterations* 200)
(defparameter *palette* " .:-=+*#%@")

(defun mandelbrot-iterations (c max-iter)
  "Return the number of iterations it takes for point C to escape the Mandelbrot set."
  (loop with z of-type (complex double-float) = #C(0d0 0d0)
        for iter from 1 to max-iter
        do (setf z (+ (* z z) c))
           (when (> (abs z) 2d0)
             (return iter))
        finally (return max-iter)))

(defun iteration->char (iter max-iter)
  "Map an iteration count to a palette character for ASCII rendering."
  (let* ((palette *palette*)
         (last-index (1- (length palette))))
    (if (>= iter max-iter)
        (char palette last-index)
        (let* ((ratio (/ iter (float max-iter)))
               (index (min last-index (max 0 (floor (* ratio last-index))))))
          (char palette index)))))

(defun draw-mandelbrot (&key (width *default-width*)
                             (height *default-height*)
                             (max-iter *default-max-iterations*)
                             (stream *standard-output*))
  "Render the Mandelbrot set to STREAM."
  (let* ((x-min -2.5d0) (x-max 1.0d0)
         (y-min -1.5d0) (y-max 1.5d0)
         (x-step (/ (- x-max x-min) (max 1 (1- width))))
         (y-step (/ (- y-max y-min) (max 1 (1- height)))))
    (loop for y from 0 below height
          for imag = (- y-max (* y y-step))
          do (loop for x from 0 below width
                   for real = (+ x-min (* x x-step))
                   for iter = (mandelbrot-iterations (complex real imag) max-iter)
                   do (write-char (iteration->char iter max-iter) stream))
             (terpri stream))
    (finish-output stream)))

(defun main-brot ()
  "Program entry point. Optionally takes an output path as the first CLI argument."
  (let* ((args (rest sb-ext:*posix-argv*))
         (output-path (first args)))
    (if output-path
        (with-open-file (stream output-path
                                :direction :output
                                :if-exists :supersede
                                :if-does-not-exist :create)
          (draw-mandelbrot :stream stream))
        (draw-mandelbrot)))
  (sb-ext:exit :code 0))
