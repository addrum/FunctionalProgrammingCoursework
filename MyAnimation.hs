module MyAnimation where

import Animation

-- x, y, cartSpeed, radius, startX, startY, endX, endY, angle, wheelSpeed
type Cart = (Double, Double, Double, Double, Double, Double, Double, Double, Double, Double)

wheelBody :: Double -> Animation
wheelBody radius = 
        withBorder (always black) (always 8) 
            (withoutPaint (circle (always radius)))

spoke :: Double -> Animation
spoke radius =
        combine [
            rotate (always (i * 90))
            (translate (always ((-4, -radius)))
                (withPaint (always black)
                    (rect (always 8) (always (radius * 2)))
                )
            )
        | i <- [1..2]]

wheel :: Double -> Double -> Double -> Double -> Animation
wheel x y speed radius =
        translate (always (x, y))
            (rotate (spinner speed)
            (wheelBody radius `plus` spoke radius))

cart :: Double -> Double -> Animation
cart x y =
        withPaint (always black)
            (polygon [((x - 40), 0), (((x * 3) + 40), 0), ((x * 3), y), (x, y)])

minecart :: Cart -> Animation
minecart (x, y, cartSpeed, radius, startX, startY, endX, endY, angle, wheelSpeed) =
            translate (repeatSmooth (startX, startY) [(0, (startX, startY)), (cartSpeed, (endX, endY))])
            (rotate (always angle)
                (
                    (cart x y) 
                    `plus` 
                    ((wheel x y wheelSpeed radius) 
                    `plus` 
                    (wheel (x * 3) y wheelSpeed radius))
                )
            )

cartProperties :: [Cart]
cartProperties = 
                [
                    (60, 70, 10, 30, -300, 300, 1000, 400, 0, 10),
                    (30, 40, 20, 15, -400, 500, 1000, 100, -24, 20),
                    (40, 50, 15, 15, 1000, -100, -300, 200, -15, -15)
                ]

allCarts :: [Cart] -> Animation 
allCarts carts = combine (map minecart carts)

picture :: Animation
picture = allCarts cartProperties

test :: IO ()
test = writeFile "test.svg" (svg 800 600 picture)