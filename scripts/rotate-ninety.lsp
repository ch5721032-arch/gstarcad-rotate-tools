;; rotate-ninety.lsp - One-command 90 degree rotations
;; Commands: ROT90 / ROT180 / ROT270
;; Usage: each command asks for a selection and a base point
(defun rot-quick (deg / ss bp )
  (setq ss (ssget "\nSelect objects: "))
  (if ss
    (progn
      (setq bp (getpoint "\nBase point: "))
      (if bp
        (command "_.ROTATE" ss "" bp deg)
      )
    )
  )
  (princ)
)
(defun c:ROT90 ( ) (rot-quick (* pi 0.5)))
(defun c:ROT180 ( ) (rot-quick pi))
(defun c:ROT270 ( ) (rot-quick (* pi 1.5)))
