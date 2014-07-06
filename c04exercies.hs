safeHead :: [a] -> Maybe a
safeHead (x:xs) = Just x
safeHead [] = Nothing

-- splitWith :: (a -> Bool) -> [a] -> [[a]]
splitWith _ [] = []
splitWith f xs =
    let g x = not (f x)
        (pre,suf) = break f xs
    in pre : case suf of
        "" -> []
        suf -> splitWith f (tail suf)

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
