import Control.Monad.Writer
import Control.Monad.State
import Data.Ratio()

gcd' :: Int -> Int -> Writer [String] Int
gcd' a b
    | b == 0 = do
        tell ["Finished with " ++ show a]
        return a
    | otherwise = do
        tell [show a ++ " mod " ++ show b ++ " = " ++ show (a `mod` b)]
        gcd' b (a `mod` b)


gcdReverse :: Int -> Int -> Writer [String] Int
gcdReverse a b
    | b == 0 = do
        tell ["Finished with " ++ show a]
        return a
    | otherwise = do
        result <- gcdReverse b (a `mod` b)
        tell [show a ++ " mod " ++ show b ++ " = " ++ show (a `mod` b)]
        return result

newtype DiffList a = DiffList { getDiffList :: [a] -> [a] }

toDiffList :: [a] -> DiffList a
toDiffList xs = DiffList (xs++)
fromDiffList :: DiffList a -> [a]
fromDiffList (DiffList f) = f []

instance Monoid (DiffList a) where
    mempty = DiffList (\xs -> [] ++ xs)
    (DiffList f) `mappend` (DiffList g) = DiffList (\xs -> f (g xs))

type Stack = [Int]

popi :: Stack -> (Int, Stack)
popi (x:xs) = (x, xs)
popi [] = (-1, [])

pushi :: Int -> Stack -> ((), Stack)
pushi i s = ((), i:s)

runStacki :: Stack -> (Int, Stack)
runStacki s = let
    ((),s1) = pushi 4 s
    (_,s2) = popi s1
    in popi s2

pops :: State Stack Int
pops = state $ \(x:xs) -> (x,xs)

pushs :: Int -> State Stack ()
pushs a = state $ \xs -> ((),a:xs)

runStacks1 :: State Stack Int
runStacks1 = do
        pushs 4
        _ <- pops
        pops

runStacks2 :: State Stack ()
runStacks2 = do
        a <- pops
        if a /= 5
            then pushs a
            else do
                pushs 4
                pushs 3
                pushs 2
                pushs 1

newtype Prob a = Prob { getProb :: [(a, Rational)] } deriving (Show)
instance Functor Prob where
        fmap f (Prob xs) = Prob $ map (\(x,p) -> (f x, p)) xs
