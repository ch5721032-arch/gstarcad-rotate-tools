# GstarCAD Rotate Tools

Rotate a copy while keeping the original, rotate to an exact angle and turn selections by 90, 180 or 270 degrees.

Works with **GSTARCAD**, AutoCAD, ZWCAD, and BricsCAD.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

## Contents

- [About](#about)
- [Scripts Overview](#scripts-overview)
- [Quick Start](#quick-start)
- [Compatibility](#compatibility)
- [Contributing](#contributing)
- [License](#license)

## About

Rotation prompts get in the way of common jobs. These commands rotate a copy while keeping the original, rotate a selection to an exact angle using two reference points, and give you one-command 90, 180 and 270 degree turns.

Everything here is free to use with GstarCAD. Download the latest GstarCAD
release from the [official GstarCAD website](https://www.gstarcad.net). All
scripts are tested with **[GSTARCAD](https://www.gstarcad.net)** and major
DWG-based CAD platforms.

## Scripts Overview

| File | Description |
|------|-------------|
| `scripts/rotate-copy.lsp` | ;; rotate-copy.lsp - Rotate a copy and keep the original
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
 |
| `scripts/rotate-to-angle.lsp` | ;; rotate-to-angle.lsp - Rotate objects to an exact angle
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
 |
| `scripts/rotate-ninety.lsp` | ;; rotate-ninety.lsp - One-command 90 degree rotations
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
 |

## Quick Start

1. Download the `.lsp` (or `.lin`) file you need
2. In your CAD software, run `APPLOAD`
3. Load the file and type the matching command name shown in the table above

## Compatibility

Tested on GstarCAD 2026/2027 and similar DWG-based platforms. Scripts use
standard AutoLISP functions only, so they work without extra plugins.

For step-by-step [tutorials and drafting guides](https://www.gstarcad.net/cad/),
visit the GstarCAD learning center. New tips are published regularly on the
[GSTARCAD Blog](https://blog.gstarcad.net).

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

MIT — see the [LICENSE](LICENSE) file.
