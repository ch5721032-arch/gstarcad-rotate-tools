;; rotate-copy.lsp - Rotate a copy and keep the original
;; Command: ROTCOPY
;; Usage: select objects, base point, then the angle in degrees
(defun c:ROTCOPY ( / ss bp ang )
  (setq ss (ssget "\nSelect objects: "))
  (if ss
    (progn
      (setq bp (getpoint "\nBase point: "))
      (setq ang (getreal "\nRotation angle (degrees): "))
      (if (and bp ang)
        (progn
          (command "_.ROTATE" ss "" bp "_C" ang)
          (princ "\nRotated copy created.")
        )
      )
    )
  )
  (princ)
)
