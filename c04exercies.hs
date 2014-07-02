safeHead :: [a] -> Maybe a
safeHead (x:xs) = Just x
safeHead [] = Nothing

splitWith :: (a -> Bool) -> [a] -> [[a]]
splitWith f xs = 
  let g x = not (f x)
  in break g xs
