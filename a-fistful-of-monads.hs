
import Control.Monad

sevensOnly :: [Int]  
sevensOnly = do  
    x <- [1..50]  
    guard ('7' `elem` show x)  
    return x  

sevensOnly2 :: [Int] -> [Int]  
sevensOnly2 xs = do  
    x <- xs
    guard ('7' `elem` show x)  
    return x  
