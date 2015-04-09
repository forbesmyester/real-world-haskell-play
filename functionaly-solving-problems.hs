
import qualified Data.Map as Map

isSolved :: [String] -> Bool
isSolved strs = length strs == 1

processOneCalc :: [Int] -> Int -> Int -> (Maybe (Int -> Int -> Int)) -> [Int]
processOneCalc pre secondLast last (Nothing) = pre ++ [ secondLast , last ]
processOneCalc pre secondLast last (Just op) = pre ++ [ op secondLast last ]

oneCalc :: [String] -> String -> [String]
oneCalc [] curr = [curr]
oneCalc [a] curr = [a, curr]
oneCalc acc curr = map show $
    processOneCalc (map read pre) (read secondLast) (read last) op
    where ops = Map.fromList [("*", (\ a b -> a * b))
                             ,("+", (\ a b -> a + b))
                             ,("-", (\ a b -> a - b))
                             ,("/", (\ a b -> a `div` b))]
          op = Map.lookup curr ops
          (pre,[secondLast, last]) = splitAt (length acc - 2) acc

-- (last:secondLast:pre') = reverse acc

-- foldl oneCalc ["1","2","3","+","-"]
