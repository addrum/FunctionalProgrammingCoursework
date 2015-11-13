module Demo where
import Animation

pic :: Animation
pic =
    withPaint (always blue)
    (combine
        [translate (always (50, 50 * i))
            (rect (always (50 * i)) (always 40))
        | i <- [1..10]])

circleSquare = 
    withPaint (always blue)
    (rect (always 100) (always 100))
    `plus`
    translate (always (50, 50))
    (withPaint (always yellow)
    (circle (always 50)))

row =
    combine
        [(translate (always (20 * i, 20 * j))
                (withPaint (always blue) (rect (always 20) (always 20))))
         `plus`
            (translate (always (20 * i, 20 * j))
                (withPaint (always yellow) (circle (always 10))))
        | i <- [1..8], j <- [1..8]]

woCol =
    translate (always (200, 200))
        (withBorder (always red) (always 40)
            (withoutPaint (circle (always 100))))
    `plus`
    translate (always (50, 175))
        (withPaint (always blue)
            (rect (always 300) (always 50)))

partial =
    translate (always (200, 200))
        (withBorder (always red) (always 40)
            (withoutPaint (circle (always 100))))
    `plus`
    translate (always (50, 175))
        (withGenPaint (always blue) (cycleSmooth 5 [0, 1])
            (rect (always 300) (always 50)))

target =
    translate (always (100, 197))
        (rect (always 200) (always 7))
    `plus`
    translate (always (197, 100))
        (rect (always 7) (always 200))
    `plus`
    (translate (always (200, 200))
        (combine
            [(withBorder (always red) (always 7)
                (withoutPaint (circle (always (15 * i)))))
            | i <- [1..5]]))

scal =
    translate (cycleSmooth 5 [(200, 300), (400, 500)])
        (rotate (spinner 5)
            (scale (always (1.5, 4))
                (withPaint (cycleSteps 4 [green, blue, red])
                    (circle (cycleSmooth 7 [30, 50])))))

test :: IO ()
test = writeFile "test.svg" (svg 800 600 pic)
cirSqr = writeFile "circleSquare.svg" (svg 800 600 circleSquare)
r = writeFile "row.svg" (svg 800 600 row)
withoutColour = writeFile "woCol.svg" (svg 800 600 woCol)
partialTrans = writeFile "partial.svg" (svg 800 600 partial)
t = writeFile "target.svg" (svg 800 600 target)
s = writeFile "scale.svg" (svg 800 600 scal)