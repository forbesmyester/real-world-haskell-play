
import System.Environment
import System.IO
import System.IO.Error


toTry = attempt 1
handleErr = attempt 2

main = toTry `catch` handleErr

attempt n = readFile "catch-" ++ (show n) ++ ".txt"
