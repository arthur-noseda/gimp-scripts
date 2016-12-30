(define (script-fu-brightness-contrast-all-layers inImage inBrightness inContrast)
  (let*
    (
      (layers (gimp-image-get-layers inImage))
      (num-layers (car layers))
      (layer-ids (cadr layers))
      (i 0)
    )
    (gimp-image-undo-group-start inImage)
    (while (< i num-layers)
      ;(gimp-message (string-append "i: " (number->string i)))
      (let*
        ((layer (aref layer-ids i)))
        ;(gimp-message (string-append "layer: " (number->string layer)))
        (gimp-brightness-contrast layer inBrightness inContrast)
      )
      (set! i (+ i 1))
    )
    (gimp-image-undo-group-end inImage)
    (gimp-displays-flush)
  ))

(script-fu-register
   "script-fu-brightness-contrast-all-layers"  ;func name
   "Brightness-Contrast All Layers..."         ;menu label
   "Modify brightness/contrast for all layers\
of the image."                                 ;description
   "Arthur Noseda"                             ;author
   "2016"                                      ;copyright notice
   "December 30, 2016"                         ;date created
   "*"                    ;image type that the script works on
   SF-IMAGE       "Image"         1
   SF-ADJUSTMENT  "Brightness"    '(0 -127 127 1 10 0 SF-SLIDER)
                                               ;a spin-button
   SF-ADJUSTMENT  "Contrast"      '(0 -127 127 1 10 0 SF-SLIDER)
                                               ;a spin-button
 )
 (script-fu-menu-register "script-fu-brightness-contrast-all-layers" "<Image>/Colors")
