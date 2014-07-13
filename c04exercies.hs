import Data.Char (digitToInt, isDigit)

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

loop2 :: String -> Int
loop2 str = 
    let f acc cur = (acc * 10) + digitToInt cur
    in
        foldl f 0 str

asInt_fold :: String -> Int
asInt_fold ('-':str) = -1 * asInt_fold str
asInt_fold str =
    let f acc cur = (acc * 10) + digitToInt cur
    in
        foldl f 0 str

--  type ErrorMessage = String
--
-- asInt_error_foldr :: Int -> Char -> Either ErrorMessage Int
-- asInt_error_foldr acc cur | isDigit cur = acc + (digitToInt cur * 10)
-- asInt_error_foldr acc cur | cur == '-' = acc * (-1)
-- asInt_error_foldr acc cur =  "Non number found '" ++ [cur] ++ "'"
--
-- asInt_error :: String -> Either ErrorMessage Int
-- asInt_error str =
--     foldr asInt_error_foldr 0 str

myConcatFr :: [[a]] -> [a]
myConcatFr xs = 
    foldr (++) [] xs

myTakeWhileRec :: (a -> Bool) -> [a] -> [a]
myTakeWhileRec f (x:[]) = x:[]
myTakeWhileRec f (x:xs) | f x == True = x:(myTakeWhileRec f xs)
myTakeWhileRec _ _ = []

myTakeWhileFoldr :: (a -> Bool) -> [a] -> [a]
myTakeWhileFoldr pred xs =
    foldr stepr [] xs
    where stepr x acc | pred x    = x:acc
                      | otherwise = []


myAnyFoldr :: (a -> Bool) -> [a] -> Bool
myAnyFoldr pred xs = foldr stepr False xs
    where stepr x acc | acc == True    = True
                      | pred x == True = True
                      | otherwise      = False


myGroupBy :: (a -> a -> Bool) -> [a] -> [[a]]
myGroupBy pred xs = foldl step [] xs
    where step [] x                             = [[x]]
          step acc x | pred x (last (head acc)) = (init acc) ++ [ last acc ++ [x] ]
                     | otherwise                = acc ++ [[x]]


-- myCycle :: [a] -> [a]
-- myCycle xs = foldl step [] xs
--     where step acc y = acc ++ [xs !! (length acc)]

myWordsL :: String -> [String]
myWordsL str = foldl step [] str
    where
        step [] c                     = [[c]]
        step acc ' ' | last acc == "" = acc
        step acc ' '                  = acc ++ [""]
        step acc c                    = init acc ++ [(last acc) ++ [c]]

myWordsR :: String -> [String]
myWordsR str = foldr step [] str
    where
        step c []                     = [[c]]
        step ' ' acc | head acc == "" = acc
        step ' ' acc                  = "" : acc
        step c   acc                  = ([c] ++ head acc) : tail acc


myUnlines :: [String] -> String
myUnlines xs = foldl step [] xs
    where step acc x = acc ++ x ++ "\n"
