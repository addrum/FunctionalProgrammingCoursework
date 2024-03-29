module MyAnimation where

import Animation

-- position, cartSpeed, radius, startPoint, endPoint, angle, wheelSpeed
type Cart = (Point, Double, Double, Point, Point, Double, Double)

picture :: Animation
picture = allCarts cartProperties

-- builds the wheels body (without spokes)
wheelBody :: Double -> Animation
wheelBody radius = 
        withBorder (always black) (always 8) 
            (withoutPaint (circle (always radius)))

-- builds a pair of spokes and moves them to correct position based on the radius of the wheel,
-- rotates them so they are perpendicular to each other
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

-- builds each wheel, moves it, rotates it, and combines it with the spokes
wheel :: Point -> Double -> Double -> Animation
wheel position speed radius =
        translate (always position)
            (rotate (spinner speed)
            (wheelBody radius `plus` spoke radius))

-- builds the carts body (without the wheels)
cart :: Point -> Animation
cart (x, y) =
        withPaint (always black)
            (polygon [((x - 40), 0), (((x * 3) + 40), 0), ((x * 3), y), (x, y)])

-- builds a complete minecart
minecart :: Cart -> Animation
minecart (position, cartSpeed, radius, startPoint, endPoint, angle, wheelSpeed) =
            moveCart (cartSpeed, startPoint, endPoint)
                (rotate (always angle)
                    (
                        (cart position) 
                        `plus` 
                        ((wheel position (speed wheelSpeed) radius) 
                        `plus` 
                        (wheel (secondWheel position) (speed wheelSpeed) radius))
                    )
                )

-- calculates the speed of a pair of wheels
speed :: Double -> Double
speed radius = 50 / radius

-- helper function to move the second wheel to the correct place
secondWheel :: Point -> Point
secondWheel (x, y) = ((x * 3), y)

-- helper function to move the cart to a position
moveCart :: (Double, Point, Point) -> Animation -> Animation
moveCart (cartSpeed, startPoint, endPoint) =
        translate (repeatSmooth startPoint [(0, startPoint), (cartSpeed, endPoint)])

-- list of properties for each cart
cartProperties :: [Cart]
cartProperties = 
                [
                    ((60, 70), 10, 30, (-300, 300), (1000, 400), 0, 10),
                    ((30, 40), 20, 15, (-400, 500), (1000, 100), -24, 29),
                    ((40, 50), 15, 15, (1000, -100), (-300, 200), -15, -15)
                ]

-- maps each element of the list to an attribute of a minecart and combines them all for
-- a complete animation
allCarts :: [Cart] -> Animation 
allCarts carts = combine (map minecart carts)

test :: IO ()
test = writeFile "test.svg" (svg 800 600 picture)