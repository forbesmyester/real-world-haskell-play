-- (C) Part Hoodlums (14 May 2015 in London), Part Myself
module TwentyFour where

import System.Random
import Control.Applicative
import Text.Printf
import Data.Foldable hiding (elem)
import Data.Char


main :: IO ()
main = do
        rands' <- randomRs (1 :: Int,9) <$> newStdGen
        let rands = take 4 rands'
        print rands
        input <- getLine
        case parse rands input of
            Left err -> printf "Invalid: %s" err
            Right val -> if val == 24 then putStrLn "you win" else putStrLn "Wrong"


rpn :: [Int] -> [Rational] -> Char -> Either String [Rational]
rpn _ (x:y:zs) c
    | c == '+' = return $ x + y : zs
    | c == '-' = return $ y - x : zs
    | c == '*' = return $ x * y : zs
    | c == '/' = return $ x / y : zs
rpn goodInts zs d | isDigit d, i <- digitToInt d, i `elem` goodInts = return $ fromIntegral i : zs
rpn _ _ c = Left $ printf "Unrecognized Char '%c'" c


parse :: [Int] -> String -> Either String Rational
parse goodInts s = do
    stack <- foldlM (rpn goodInts) [] s
    case stack of
        [] -> Left "Empty"
        [v] -> Right v
        _ -> Left "Invalid"

