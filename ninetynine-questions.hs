-- __NOTOC__
import Data.List

-- This is part of [[H-99:_Ninety-Nine_Haskell_Problems|Ninety-Nine Haskell Problems]], based on [https://sites.google.com/site/prologsite/prolog-problems  Ninety-Nine Prolog Problems] and [http://www.ic.unicamp.br/~meidanis/courses/mc336/2006s2/funcional/L-99_Ninety-Nine_Lisp_Problems.html Ninety-Nine Lisp Problems].

-- == Problem 1 ==

-- (*) Find the last element of a list.

-- (Note that the Lisp transcription of this problem is incorrect.)

-- Example in Haskell:

-- <haskell>
myLast :: [a] -> a
myLast xs = head $ reverse xs
-- Prelude> myLast [1,2,3,4]
-- 4
-- Prelude> myLast ['x','y','z']
-- 'z'
-- </haskell>



-- [[99 questions/Solutions/1 | Solutions]]


-- == Problem 2 ==

-- (*) Find the last but one element of a list.

-- (Note that the Lisp transcription of this problem is incorrect.)

-- Example in Haskell:

-- <haskell>
myButLast :: [a] -> a
myButLast = head . tail . reverse
-- myButLast = (!! 1) . reverse
-- myButLast = snd . head .reverse . zip xs (tail xs)
-- Prelude> myButLast [1,2,3,4]
-- 3
-- Prelude> myButLast ['a'..'z']
-- 'y'
-- </haskell>

-- [[99 questions/Solutions/2 | Solutions]]


-- == Problem 3 ==

-- (*) Find the K'th element of a list. The first element in the list is number 1.

-- Example:

-- <pre>
-- * (element-at '(a b c d e) 3)
-- c
-- </pre>

-- Example in Haskell:

-- <haskell>
elementAt :: [a] -> Int -> a
elementAt xs n = xs !! (n-1)
-- Prelude> elementAt [1,2,3] 2
-- 2
-- Prelude> elementAt "haskell" 5
-- 'e'
-- </haskell>

-- [[99 questions/Solutions/3 | Solutions]]


-- == Problem 4 ==

-- (*) Find the number of elements of a list.

-- Example in Haskell:

-- <haskell>
myLength :: [a] -> Int
myLength xs = foldl (\n _ -> n + 1) 0 xs
-- Prelude> myLength [123, 456, 789]
-- 3
-- Prelude> myLength "Hello, world!"
-- 13
-- </haskell>

-- [[99 questions/Solutions/4 | Solutions]]


-- == Problem 5 ==

-- (*) Reverse a list.

-- Example in Haskell:

-- <haskell>
myReverse :: [a] -> [a]
myReverse (x:xs) = myReverse xs ++ [x]
myReverse [] = []
-- Prelude> myReverse "A man, a plan, a canal, panama!"
-- "!amanap ,lanac a ,nalp a ,nam A"
-- Prelude> myReverse [1,2,3,4]
-- [4,3,2,1]
-- </haskell>

-- [[99 questions/Solutions/5 | Solutions]]


-- == Problem 6 ==

-- (*) Find out whether a list is a palindrome. A palindrome can be read forward or backward; e.g. (x a m a x).

-- Example in Haskell:

-- <haskell>
isPalindrome :: (Eq a) => [a] -> Bool
isPalindrome xs = reverse xs == xs
isPalindromeTest :: Bool
isPalindromeTest = [isPalindrome [1,2,3,2,1], isPalindrome [1,2,2,1], isPalindrome "madamimadam", isPalindrome [1,2,3], isPalindrome [1,2,4,8,16,8,4,2,1]] == [True, True, True, False, True]
-- *Main> isPalindrome [1,2,3]
-- False
-- *Main> isPalindrome "madamimadam"
-- True
-- *Main> isPalindrome [1,2,4,8,16,8,4,2,1]
-- True
-- </haskell>

-- [[99 questions/Solutions/6 | Solutions]]


-- == Problem 7 ==

-- (**) Flatten a nested list structure.

-- Transform a list, possibly holding lists as elements into a `flat' list by replacing each list with its elements (recursively).

-- Example:

-- <pre>
-- * (my-flatten '(a (b (c d) e)))
-- (A B C D E)
-- </pre>

-- Example in Haskell:

-- We have to define a new data type, because lists in Haskell are homogeneous. 
-- <haskell>
--  data NestedList a = Elem a | List [NestedList a]
-- </haskell>

-- <haskell>
data NestedList a = Elem a | List [NestedList a] deriving (Show, Eq)
flatten :: NestedList b -> [b]
flatten (Elem x) = [x]
flatten (List (x:xs)) = flatten x ++ flatten (List xs)
flatten (List []) = []
-- *Main> flatten (Elem 5)
-- [5]
-- *Main> flatten (List [Elem 1, List [Elem 2, List [Elem 3, Elem 4], Elem 5]])
-- [1,2,3,4,5]
-- *Main> flatten (List [])
-- []
-- </haskell>



-- [[99 questions/Solutions/7 | Solutions]]

-- == Problem 8 ==

-- (**) Eliminate consecutive duplicates of list elements.

-- If a list contains repeated elements they should be replaced with a single copy of the element. The order of the elements should not be changed.

-- Example:

-- <pre>
-- * (compress '(a a a a b c c a a d e e e e))
-- (A B C A D E)
-- </pre>

-- Example in Haskell:

-- <haskell>
compressWorker :: (Eq a) => [a] -> a -> [a]
compressWorker (y:ys) x = if x == y
                          then y:ys
                          else x:y:ys
compressWorker [] x = [x]

compress :: (Eq a) => [a] -> [a]
compress a = reverse $ foldl compressWorker [] a
-- > compress "aaaabccaadeeee"
-- "abcade"
-- </haskell>

-- [[99 questions/Solutions/8 | Solutions]]

-- == Problem 9 ==

-- (**) Pack consecutive duplicates of list elements into sublists.
-- If a list contains repeated elements they should be placed in separate sublists.

-- Example:

-- <pre>
-- * (pack '(a a a a b c c a a d e e e e))
-- ((A A A A) (B) (C C) (A A) (D) (E E E E))
-- </pre>

-- Example in Haskell:

-- <haskell>
-- *Main> pack ['a', 'a', 'a', 'a', 'b', 'c', 'c', 'a', 
--              'a', 'd', 'e', 'e', 'e', 'e']
-- ["aaaa","b","cc","aa","d","eeee"]
-- </haskell>

pack' :: (Eq a) => [a] -> [[a]]
pack' = group
packWorker :: (Eq a) => [[a]] -> a -> [[a]]
packWorker (x:xs) y
    | y == head x = (y:x):xs
    | otherwise = [y] : [x] ++ xs
packWorker [] n = [[n]]
pack :: (Eq a) => [a] -> [[a]]
pack xs = reverse $ foldl packWorker [] xs

-- [[99 questions/Solutions/9 | Solutions]]

-- == Problem 10 ==

-- (*) Run-length encoding of a list.
-- Use the result of problem P09 to implement the so-called run-length encoding data compression method. Consecutive duplicates of elements are encoded as lists (N E) where N is the number of duplicates of the element E.

-- Example:
-- <pre>
-- * (encode '(a a a a b c c a a d e e e e))
-- ((4 A) (1 B) (2 C) (2 A) (1 D)(4 E))
-- </pre>

-- Example in Haskell:
-- <haskell>
encode :: (Eq a) => [a] -> [(Int, a)]
encode zs = map (\(x:xs) -> (length xs + 1, x)) $ pack zs

-- encode "aaaabccaadeeee"
-- [(4,'a'),(1,'b'),(2,'c'),(2,'a'),(1,'d'),(4,'e')]
-- </haskell>

-- [[99 questions/Solutions/10 | Solutions]]


-- [[Category:Tutorials]]


-- __NOTOC__

-- This is part of [[H-99:_Ninety-Nine_Haskell_Problems|Ninety-Nine Haskell Problems]], based on [https://prof.ti.bfh.ch/hew1/informatik3/prolog/p-99/ Ninety-Nine Prolog Problems] and [http://www.ic.unicamp.br/~meidanis/courses/mc336/2006s2/funcional/L-99_Ninety-Nine_Lisp_Problems.html Ninety-Nine Lisp Problems].
 
-- == Problem 11 ==

-- (*) Modified run-length encoding.

-- Modify the result of problem 10 in such a way that if an element has no duplicates it is simply copied into the result list. Only elements with duplicates are transferred as (N E) lists.

-- Example:

-- <pre>
-- * (encode-modified '(a a a a b c c a a d e e e e))
-- ((4 A) B (2 C) (2 A) D (4 E))
-- </pre>

-- Example in Haskell:

-- <haskell>
-- P11> encodeModified "aaaabccaadeeee"
-- [Multiple 4 'a',Single 'b',Multiple 2 'c',
--  Multiple 2 'a',Single 'd',Multiple 4 'e']
-- </haskell>

-- [[99 questions/Solutions/11 | Solutions]]

-- == Problem 12 ==

-- (**) Decode a run-length encoded list.

-- Given a run-length code list generated as specified in problem 11. Construct its uncompressed version.

-- Example in Haskell:

-- <haskell>
-- P12> decodeModified 
--        [Multiple 4 'a',Single 'b',Multiple 2 'c',
--         Multiple 2 'a',Single 'd',Multiple 4 'e']
-- "aaaabccaadeeee"
-- </haskell>

-- [[99 questions/Solutions/12 | Solutions]]

-- == Problem 13 ==

-- (**) Run-length encoding of a list (direct solution). 

-- Implement the so-called run-length encoding data compression method directly. I.e. don't explicitly create the sublists containing the duplicates, as in problem 9, but only count them. As in problem P11, simplify the result list by replacing the singleton lists (1 X) by X.

-- Example:

-- <pre>
-- * (encode-direct '(a a a a b c c a a d e e e e))
-- ((4 A) B (2 C) (2 A) D (4 E))
-- </pre>

-- Example in Haskell:

-- <haskell>
-- P13> encodeDirect "aaaabccaadeeee"
-- [Multiple 4 'a',Single 'b',Multiple 2 'c',
--  Multiple 2 'a',Single 'd',Multiple 4 'e']
-- </haskell>

-- [[99 questions/Solutions/13 | Solutions]]

-- == Problem 14 ==

-- (*) Duplicate the elements of a list.

-- Example:

-- <pre>
-- * (dupli '(a b c c d))
-- (A A B B C C C C D D)
-- </pre>

-- Example in Haskell:

-- <haskell>
-- > dupli [1, 2, 3]
-- [1,1,2,2,3,3]
-- </haskell>

-- [[99 questions/Solutions/14 | Solutions]]


-- == Problem 15 ==

-- (**) Replicate the elements of a list a given number of times.

-- Example:

-- <pre>
-- * (repli '(a b c) 3)
-- (A A A B B B C C C)
-- </pre>

-- Example in Haskell:

-- <haskell>
-- > repli "abc" 3
-- "aaabbbccc"
-- </haskell>

-- [[99 questions/Solutions/15 | Solutions]]


-- == Problem 16 ==

-- (**) Drop every N'th element from a list.

-- Example:

-- <pre>
-- * (drop '(a b c d e f g h i k) 3)
-- (A B D E G H K)
-- </pre>

-- Example in Haskell:

-- <haskell>
-- *Main> dropEvery "abcdefghik" 3
-- "abdeghk"
-- </haskell>

-- [[99 questions/Solutions/16 | Solutions]]

        
-- == Problem 17 ==

-- (*) Split a list into two parts; the length of the first part is given.

-- Do not use any predefined predicates.

-- Example:

-- <pre>
-- * (split '(a b c d e f g h i k) 3)
-- ( (A B C) (D E F G H I K))
-- </pre>

-- Example in Haskell:

-- <haskell>
-- *Main> split "abcdefghik" 3
-- ("abc", "defghik")
-- </haskell>

-- [[99 questions/Solutions/17 | Solutions]]


-- == Problem 18 ==

-- (**) Extract a slice from a list.

-- Given two indices, i and k, the slice is the list containing the elements between the i'th and k'th element of the original list (both limits included). Start counting the elements with 1.

-- Example:

-- <pre>
-- * (slice '(a b c d e f g h i k) 3 7)
-- (C D E F G)
-- </pre>

-- Example in Haskell:

-- <haskell>
-- *Main> slice ['a','b','c','d','e','f','g','h','i','k'] 3 7
-- "cdefg"
-- </haskell>

-- [[99 questions/Solutions/18 | Solutions]]


-- == Problem 19 ==

-- (**) Rotate a list N places to the left.

-- Hint: Use the predefined functions length and (++).

-- Examples:

-- <pre>
-- * (rotate '(a b c d e f g h) 3)
-- (D E F G H A B C)

-- * (rotate '(a b c d e f g h) -2)
-- (G H A B C D E F)
-- </pre>

-- Examples in Haskell:

-- <haskell>
-- *Main> rotate ['a','b','c','d','e','f','g','h'] 3
-- "defghabc"

-- *Main> rotate ['a','b','c','d','e','f','g','h'] (-2)
-- "ghabcdef"
-- </haskell>

-- [[99 questions/Solutions/19 | Solutions]]

       
-- == Problem 20 ==

-- (*) Remove the K'th element from a list.

-- Example in Prolog:

-- <pre>
-- ?- remove_at(X,[a,b,c,d],2,R).
-- X = b
-- R = [a,c,d]
-- </pre>

-- Example in Lisp:

-- <pre>
-- * (remove-at '(a b c d) 2)
-- (A C D)
-- </pre>

-- (Note that this only returns the residue list, while the Prolog version also returns the deleted element.)

-- Example in Haskell:

-- <haskell>
-- *Main> removeAt 2 "abcd"
-- ('b',"acd")
-- </haskell>

-- [[99 questions/Solutions/20 | Solutions]]


-- [[Category:Tutorials]]

