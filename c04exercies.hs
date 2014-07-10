import Data.Char (digitToInt)

safeHead :: [a] -> Maybe a
safeHead (x:xs) = Just x
safeHead [] = Nothing

splitWith :: (a -> Bool) -> [a] -> [[a]]
splitWith _ [] = []
splitWith f xs =
    let g x = not (f x)
        (pre,suf) = break f xs
    in pre : case suf of
        [] -> []
        suf -> splitWith f (tail suf)

firstWordFromLines :: String -> [String]
firstWordFromLines str = 
    let notSpace c = not (' ' == c)
        fw s = takeWhile notSpace s
    in 
        map fw (lines str)

grabInLine n line = line !! n
grabInLines n lines = map (grabInLine n) lines
grabInLinesUpto :: Int -> Int -> [String] -> [String]
grabInLinesUpto upto n lines | (n == upto) = []
grabInLinesUpto upto n lines = (grabInLines n lines) : (grabInLinesUpto upto (n+1) lines)

transposedFirstLettersFromLines :: String -> String
transposedFirstLettersFromLines inStr =
    let lineLengths = map length (lines inStr)
        upto = minimum lineLengths
    in
        unlines (grabInLinesUpto upto 0 (lines inStr))

loop :: Int -> String -> Int
loop acc [] = acc
loop acc (x:xs) =
    let acc' = (acc * 10) + digitToInt x
    in loop acc' xs

myConcat :: [[a]] -> [a]
myConcat [] = []
myConcat (x:xs) = x ++ (myConcat xs)

myHead :: [a] -> a
myHead (x:xs) = x

myTail :: [a] -> [a]
myTail (x:xs) = xs

myLast :: [a] -> a
myLast [] = error "Nothing there"
myLast (a:as) =
    if null as
    then a
    else myLast as

myInit :: [a] -> [a]
myInit [] = error "Not Enough"
myInit (x:[]) = []
myInit (x:xs) = x : (myInit xs)

myOr :: (a -> Bool) -> [a] -> Bool
myOr pred [] = False
myOr pred (x:xs) =
    if (pred x) == True
    then True
    else myOr pred xs

