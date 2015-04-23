applyMaybe :: Maybe a -> (a -> Maybe b) -> Maybe b
applyMaybe Nothing _  = Nothing
applyMaybe (Just x) f = f x

type Birds = Int
type Pole = (Birds, Birds)

leftLand1 :: Birds -> Pole -> Pole
leftLand1 num (leftPole, rightPole) = (leftPole + num, rightPole)

rightLand1 :: Birds -> Pole -> Pole
rightLand1 num (leftPole, rightPole) = (leftPole, rightPole + num)
-- 1 (1,1) -: rightLand


leftLand2 :: Birds -> Pole -> Maybe Pole
leftLand2 num (leftPole, rightPole)
       | abs ((leftPole + num) - rightPole) < 4 = Just (leftPole + num, rightPole)
       | otherwise = Nothing

rightLand2 :: Birds -> Pole -> Maybe Pole
rightLand2 num (leftPole, rightPole)
        | abs ((rightPole + num) - leftPole) < 4 = Just (leftPole, rightPole + num)
        | otherwise = Nothing
-- return (0,0) >>= leftLand 1 >>= rightLand 2

leftLand3 :: Birds -> Pole -> Either String Pole
leftLand3 num (leftPole, rightPole)
       | abs ((leftPole + num) - rightPole) < 4 = Right (leftPole + num, rightPole)
       | otherwise = Left "Too many birds on the left side"

rightLand3 :: Birds -> Pole -> Either String Pole
rightLand3 num (leftPole, rightPole)
        | abs ((rightPole + num) - leftPole) < 4 = Right (leftPole, rightPole + num)
        | otherwise = Left "Too many birds on the right side"
-- return (2,2) >>= leftLand3 5
