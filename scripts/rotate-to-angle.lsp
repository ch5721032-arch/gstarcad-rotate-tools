;; rotate-to-angle.lsp - Rotate objects to an exact angle
;; Command: ROT2ANG
;; Usage: select objects, base point, two points of the current direction,
;;        then type the target angle in degrees
(defun c:ROT2ANG ( / ss bp p1 p2 cur target delta )
  (setq ss (ssget "\nSelect objects: "))
  (if ss
    (progn
      (setq bp (getpoint "\nBase point: "))
      (setq p1 (getpoint bp "\nFirst point of the current direction: "))
      (setq p2 (getpoint p1 "\nSecond point of the current direction: "))
      (if (and bp p1 p2)
        (progn
          (setq cur (angle p1 p2))
          (setq target (/ (* pi (getreal "\nTarget angle (degrees): ")) 180.0))
          (setq delta (- target cur))
          (command "_.ROTATE" ss "" bp delta)
          (princ "\nRotated to the target angle.")
        )
      )
    )
  )
  (princ)
)
