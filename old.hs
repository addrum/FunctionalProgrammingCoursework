module MyAnimation where

import Animation

waves :: Double -> Animation
waves x = 
        translate
            (always (400, 300)) 
            ( combine [wave i | i <- [1..x]])

transmitter :: Animation
transmitter = 
        translate 
            (always (400, 300))
            (circle (always 25))

wave :: Time -> Animation
wave t =
        scale 
            (repeatSmooth (0, 0) [(t, (0, 0)), ((t + 10), (5, 5))])
            ( withGenPaint (always blue) (repeatSmooth 0 [(t, 1), ((t + 4), 0), ((t + 10), 0)])
                (circle (always 100))
            )

signal :: Double -> Animation
signal x = (waves x) `plus` transmitter

test :: Double -> IO ()
test num = writeFile "test.svg" (svg 800 600 (signal num))