palindrome :: [a] -> [a]

palindrome a = a ++ (reverse a)


isPalindrome :: Eq a => [a] -> Bool
isPalindrome a | (mod (length a) 2) > 0 = False
isPalindrome a = let len = div (length a) 2
                     x = take len a
                     y = take len (reverse a)
                 in x == y
