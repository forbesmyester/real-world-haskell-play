
-- The following is pretending to be a functor because
--
--     fmap id (CJust 0 "hi")
--
-- return `CJust 1 "hi"`, which violates the first rule of functors which
-- is:
--
--     fmap id a = a
--
-- The second rule of functors is:
--
--     fmap (f . g) = fmap f . fmap g
--
-- data CMaybe a = CNothing | CJust Int a deriving (Show)
--
-- instance Functor CMaybe where
--     fmap _ CNothing = CNothing
--     fmap f (CJust counter x) = CJust (counter+1) (f x) 


-- ## GHCI examples.
-- (Just (3 +)) <*> (Just 3) -- = Just 6 (Extracts function from left hand side, applies to right)
-- fmap (+3) (Just 3) -- = Just 6
-- fmap (+) (Just 3) <*> (Just 3) -- Just 6
-- (+) <$> (Just 3) <*> (Just 3) -- Just 6

--
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

