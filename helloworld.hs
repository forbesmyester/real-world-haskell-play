
x :: String -> IO String
x a = do
    putStrLn a
    getLine

main :: IO ()
main = do   
    line <- getLine  
    if null line  
        then return ()  
        else do  
            putStrLn $ reverseWords line  
            main  
  
reverseWords :: String -> String  
reverseWords = unwords . map reverse . words 
