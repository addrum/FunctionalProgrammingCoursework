module MyAnimation where

import Animation

picture :: Animation
picture = 
    (translate 
        -- translate param 1
        (cycleSmooth 2 [(0, 0), (100, 100), (200, 200), (300, 300), (400, 400)])
        -- translate param 2
        (
            ( scale (cycleSmooth 8 [(1, 1), (2, 2)])
                ( withGenPaint (cycleSmooth 8 [blue, white]) (cycleSmooth 8 [1.00, 0.00])
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