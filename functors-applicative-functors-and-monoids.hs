-- # What is a functor?
--
-- A functor is a thing ( like a list or tree ) that satisfies the
-- following requirements:
--
--     fmap id a = a
--     fmap (f . g) = fmap f . fmap g
--
-- This basically amounts to that it is something you can `map` over.
--
-- The function `map` == `fmap` for lists. But `fmap` can be used over any
-- data type which is a Functor. `<$>` is, for practical purposes at least
-- the infix version of `fmap.`
--
--     (+1) <$> [1,2,3] == [2,3,4]
--     fmap (+1) [1,2,3] == [2,3,4]
--
--     ============================================================
--
-- # What is an Applicative Functors
--
-- You can do
--
--     ghci> let a = fmap (*) [1,2,3,4]  
--     ghci> fmap (\f -> f 9) a == [9,18,27,36]
--
-- Or
--
--     ghci> let z = fmap (*) $ Just 4
--     ghci> fmap (\f -> f 9) z == Just 36
--
-- But what if you have the function already inside a Functor (such as IO)?
-- You can use Applicative Functors
--
--     Just (+3) <*> Just 3 == Just 6
--     pure (+3) <*> Just 3 == Just 6
--     pure (+) <*> Just 3 <*> Just 3 == Just 6
--
-- Control.Applicative also exports <$>, just like Data.Functor
--
--     (+) <$> Just 3 <*> Just 3
--
-- IO is also an Applicative Functor so the code:
-- 
-- myAction :: IO String  
-- myAction = do  
--     a <- getLine  
--     b <- getLine  
--     return $ a ++ b  
-- 
-- Could be wrote as:
-- 
--     myAction :: IO String  
--     myAction = (++) <$> getLine <*> getLine
--
-- # What is a Monoid
--
-- Monoids are things that can be empty, can be joined with other monoids
-- of the same type and can also be concatenated, but when doing so they
-- must follow specific rules, these pretty much are the following:
--
--     a mappend (b mappend c) == (a mappend b) mappend c
--     a mappend mempty == mempty mappend a == a
--     [[a],[b,c],[d]] == [a,b,c,d]
--     
-- Now if you think of this, you'd expect it to be true for numbers (where
-- mappend is + and mempty is 0) or lists (where mappend is ++ and mempty
-- is []), but it's true in lots of other ways too.


import Control.Applicative
import Control.Monad

newtype Pair b a = Pair { getPair :: (a,b) }  deriving (Eq, Show) -- Makes a newtype, like data but quicker and more restricted
instance Functor (Pair c) where fmap f (Pair (x,y)) = Pair (f x, y)
newtype Pair2 a b = Pair2 { getPair2 :: (a,b) }  deriving (Eq, Show) -- Makes a newtype, like data but quicker and more restricted
instance Functor (Pair2 c) where fmap f (Pair2 (x,y)) = Pair2 (x,f y)
-- fmap (*100) (Pair (2,3))
-- fmap (*100) (Pair2 (2,3))


-- Just "hello" >>= (\x -> Just $ head x)
wopwop :: Maybe String -> Maybe Char
wopwop str = do
        (x:xs) <- str
        Just x


-- [3,4,5] >>= (\x -> [x, -x])
-- [3,4,5] >>= (\x -> 1)
-- [3,4,5] >>= (\x -> if (x == 4) then [] else [x])

type KnightPos = (Int,Int)

knightMove :: KnightPos -> [KnightPos]
knightMove (x,y) = do
        (x', y') <- [(x+2,y+1),(x+2,y-1),(x-2,y+1),(x-2,y-1)
                  ,(x+1,y+2),(x+1,y-2),(x-1,y+2),(x-1,y-2)]
        guard (x' `elem` [1..8] && y' `elem` [1..8])
        return (x',y')

firstKnightMove3Times :: KnightPos -> [KnightPos]
firstKnightMove3Times km = do
        first <- knightMove km
        second <- knightMove first
        knightMove second

secondKnightMove3Times :: KnightPos -> [KnightPos]
secondKnightMove3Times km = return km >>= knightMove >>= knightMove >>= knightMove

