module MyAnimation where

import Animation

picture :: Animation
picture = arc 2 `plus` arc 0 

arc :: Time -> Animation
arc t =
        (translate 
            (repeatSmooth (0, 0) [(t, (0, 0)), ((t + 10), (400, 400))])
            (
                ( scale (repeatSmooth (1, 1) [((0), (1, 1)), (10, (3, 3))])
                        ( withGenPaint (always blue) (repeatSmooth t [(t, 1), ((t + 4), 0), ((t + 10), 0)])
                            (polygon [(60, 0), (35, 35), (0, 60), (40, 40)])
                        )
                )
            )
        )

test :: IO ()
test = writeFile "test.svg" (svg 800 600 picture)