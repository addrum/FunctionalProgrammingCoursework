module MyAnimation where

import Animation

picture :: Animation
picture = 
    (combine [
        (translate 
            (cycleSmooth (2 + i) [(0, 0), (100, 100), (200, 200), (300, 300), (400, 400)])
            (
                ( scale (repeatSmooth (1, 1) [(0, (1, 1)), (10, (2, 2))])
                        ( withGenPaint (always blue) (repeatSmooth 1 [(0, 1), ((2 + i), 0.5), ((4 + i), 0), ((10 + i), 0)])
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
    | i <- [1..5]])

test :: IO ()
test = writeFile "test.svg" (svg 800 600 picture)