(in-package :mgl-gpr)

;;;; Generating docs for GPR. Not included in the ASDF system.

(defun update-readmes ()
  ;; README.md has anchors, links, inline code, and other markup
  ;; added. Not necessarily the easiest on the eye in text, but looks
  ;; good on github.
  (with-open-file (stream (asdf:system-relative-pathname :mgl-gpr "README.md")
                          :direction :output
                          :if-does-not-exist :create
                          :if-exists :supersede)
    (document @gpr-manual :stream stream)
    (print-markdown-footer stream))
  ;; README is optimized for reading in text format. Has no links and
  ;; cluttery markup.
  (with-open-file (stream (asdf:system-relative-pathname :mgl-gpr "README")
                          :direction :output
                          :if-does-not-exist :create
                          :if-exists :supersede)
    (describe @gpr-manual stream)
    (print-markdown-footer stream)))

(defun print-markdown-footer (stream)
  (format stream "~%* * *~%")
  (format stream "###### \\[generated by ~
                   [MGL-PAX](https://github.com/melisgl/mgl-pax)\\]~%"))

#|

(update-readmes)

|#
