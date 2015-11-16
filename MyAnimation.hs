module MyAnimation where

import Animation

picture :: Animation
picture = 
    (translate 
        -- translate param 1
        (cycleSmooth 2 [(0, 0), (100, 100), (200, 200), (300, 300), (400, 400)])
        -- translate param 2
        (
            ( scale (repeatSmooth (1, 1) [(0, (1, 1)), (10, (2, 2))])
                ( withGenPaint (always blue) (repeatSmooth 1 [(0, 1), (2, 0.5), (4, 0), (10, 0)])
                    (circle (always 75)) 
                    `plus` 
                    (translate 
                        (always (-25, -25)) (
                            (withPaint (always white) (circle (always 100)))
                        )
                    )
                )
            )
        )
    )

test :: IO ()
test = writeFile "test.svg" (svg 800 600 picture)