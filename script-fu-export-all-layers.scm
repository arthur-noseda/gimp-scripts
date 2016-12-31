(define (script-fu-export-all-layers inImage inOutputDirectory inPrefix inSuffix)
  (let*
    (
      (layers (gimp-image-get-layers inImage))
      (num-layers (car layers))
      (layer-ids (cadr layers))
      (i 0)
      (digits (count-digits num-layers))
    )
    ;(gimp-message (string-append "digits: " (number->string digits)))
    (while (< i num-layers)
      (let*
        (
          (layer (aref layer-ids i))
          (count (- num-layers i))
          (layerName (string-append inPrefix (left-pad (number->string count) "0" digits) inSuffix))
          (pathname (string-append inOutputDirectory "/" layerName))
        )
        ;(gimp-message (string-append "i: " (number->string i) ", count: " (number->string count) ", layerName: " layerName ", pathname: " pathname))
        (gimp-file-save RUN-NONINTERACTIVE inImage layer pathname layerName)
      )
      (set! i (+ i 1))
    )
  ))

(define (count-digits n)
  (if (< n 10)
    1
    (+ 1 (count-digits (/ n 10)))
  )
)

(define (left-pad str pad len)
  (if (< (string-length str) len)
    (left-pad (string-append pad str) pad len)
    str
  )
)

(script-fu-register
   "script-fu-export-all-layers"               ;func name
   "Export All Layers..."                      ;menu label
   "Export all layers from bottom to top in\
the specified directory."                      ;description
   "Arthur Noseda"                             ;author
   "2016"                                      ;copyright notice
   "December 31, 2016"                         ;date created
   "*"                    ;image type that the script works on
   SF-IMAGE       "Image"            1
   SF-DIRNAME     "Output Directory" ""
   SF-STRING      "Prefix"           "Image-"
   SF-STRING      "Suffix"           ".jpg"
 )
 (script-fu-menu-register "script-fu-export-all-layers" "<Image>/File")
