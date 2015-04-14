import Data.List

nu :: (Eq a) => [a] -> Int
nu = length . nub
