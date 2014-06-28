addLength n (x:xs) = addLength ( n+1 ) xs
addLength n xs = n

c3Length :: [a] -> Int
c3Length xs = addLength 0 xs
