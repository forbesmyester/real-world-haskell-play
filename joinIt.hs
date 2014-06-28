joinItW sep retStr (x:xs) | length xs > 0 = joinItW sep (retStr ++ x ++ sep) xs
joinItW sep retStr (x:xs) = joinItW sep (retStr ++ x) xs
joinItW _ retStr _ = retStr

joinIt sep xs = joinItW sep "" xs
