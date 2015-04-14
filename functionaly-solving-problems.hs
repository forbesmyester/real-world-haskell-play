
import qualified Data.Map as Map

isSolved :: [String] -> Bool
isSolved strs = length strs == 1

processOneCalc :: [Int] -> Int -> Int -> (Either Int (Int -> Int -> Int)) -> [Int]
processOneCalc pre secondLast last (Left curr) = pre ++ [secondLast, last, curr]
processOneCalc pre secondLast last (Right op) = pre ++ [op secondLast last]

oneCalc :: [String] -> String -> [String]
oneCalc [] curr = [curr]
oneCalc [a] curr = [a, curr]
oneCalc acc curr = map show $
    case op of
        Nothing -> processOneCalc (map read pre) (read secondLast) (read last) (Left (read curr :: Int))
        Just op -> processOneCalc (map read pre) (read secondLast) (read last) (Right op)
    where ops = Map.fromList [("*", (\ a b -> a * b))
                             ,("+", (\ a b -> a + b))
                             ,("-", (\ a b -> a - b))
                             ,("/", (\ a b -> a `div` b))]
          op = Map.lookup curr ops
          (pre,[secondLast, last]) = splitAt (length acc - 2) acc

-- Book answer.
solveRPN :: (Num a, Read a) => String -> a  
solveRPN = head . foldl foldingFunction [] . words  
    where   foldingFunction (x:y:ys) "*" = (x * y):ys  
            foldingFunction (x:y:ys) "+" = (x + y):ys  
            foldingFunction (x:y:ys) "-" = (y - x):ys  
            foldingFunction xs numberString = read numberString:xs


-- Heathrow to London

data Node = Node Road Road | EndNode Road  
data Road = Road Int Node  

data Section = Section { getA :: Int, getB :: Int, getC :: Int } deriving (Show)  
type RoadSystem = [Section]  

data Label = A | B | C deriving (Show)  
type Path = [(Label, Int)]  

heathrowToLondon :: RoadSystem  
heathrowToLondon = [Section 50 10 30, Section 5 90 20, Section 40 2 25, Section 10 8 0]  

roadStep :: (Path, Path) -> Section -> (Path, Path)  
roadStep (pathA, pathB) (Section a b c) =   
    let priceA = sum $ map snd pathA  
        priceB = sum $ map snd pathB  
        forwardPriceToA = priceA + a  
        crossPriceToA = priceB + b + c  
        forwardPriceToB = priceB + b  
        crossPriceToB = priceA + a + c  
        newPathToA = if forwardPriceToA <= crossPriceToA  
                        then (A,a):pathA  
                        else (C,c):(B,b):pathB  
        newPathToB = if forwardPriceToB <= crossPriceToB  
                        then (B,b):pathB  
                        else (C,c):(A,a):pathA  
    in  (newPathToA, newPathToB)

optimalPath :: RoadSystem -> Path  
optimalPath roadSystem = 
    let (bestAPath, bestBPath) = foldl roadStep ([],[]) roadSystem  
    in  if sum (map snd bestAPath) <= sum (map snd bestBPath)  
            then reverse bestAPath  
            else reverse bestBPath
