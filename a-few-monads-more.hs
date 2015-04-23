
import Control.Monad.Writer

logNum :: Int -> Writer [String] Int
logNum x = writer (x, ["Got Num: " ++ show x])

multWithLog :: Writer [String] Int
multWithLog = do
        a <- logNum 3
        b <- logNum 4
        tell ["Multiply it"]
        return (a * b)
