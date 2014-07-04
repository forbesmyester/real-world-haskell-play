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
