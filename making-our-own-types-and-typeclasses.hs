import qualified Data.Map as Map

data Point = Point Float Float deriving (Show)
data Shape =
        Circle Point Float |
        Rectangle Point Point deriving (Show)

surface :: Shape -> Float
surface (Circle _ r) = pi * r ^ 2
surface (Rectangle (Point x y) (Point x2 y2)) = (x2 - x) * (y2 - y)

data Car = Car {company :: String, model :: String, year :: Int} deriving (Show)

data LockerState = Taken | Free deriving (Show, Eq)
type Code = String
type LockerMap = Map.Map Int (LockerState, Code)

lockerLookup :: Int -> LockerMap -> Either String Code
lockerLookup lockerNumber map = 
        case Map.lookup lockerNumber map of
            Nothing -> Left $ "Locker number " ++ show lockerNumber ++ " doesn't exist!"
            Just (state, code) -> if state /= Taken
                                      then Right code
                                      else Left $ "Locker " ++ show lockerNumber ++ " is already taken!"

data Tree a = EmptyTree | Node a (Tree a) (Tree a) deriving (Show, Eq, Read)
singleton :: a -> Tree a
singleton x = Node x EmptyTree EmptyTree
treeInsert x EmptyTree = singleton x
treeInsert x (Node a left right)
    | x == a = Node x left right
    | x > a = Node a left (treeInsert x right)
    | x < a = Node a (treeInsert x left) right

treeFind :: (Ord a) => a -> Tree a -> Bool
treeFind v EmptyTree = False
treeFind v (Node a left right)
    | v == a = True
    | v < a = treeFind v left
    | v > a = treeFind v right

buildTree :: (Ord a) => [a] -> Tree a
buildTree nums = foldl (\ acc v -> treeInsert v acc) EmptyTree nums

data TrafficLight = Red | Yellow | Green
instance Eq TrafficLight where
        Red == Red = True
        Green == Green = True
        Yellow == Yellow = True
        _ == _ = False

instance Show TrafficLight where
    show Red = "Red light"
    show Yellow = "Yellow light"
    show Green = "Green light"

class YesNo a where
    yesno :: a -> Bool
instance YesNo Int where
    yesno 0 = False
    yesno _ = True
instance YesNo [a] where
    yesno [] = False
    yesno _ = True
instance YesNo Bool where
    yesno = id
instance YesNo (Maybe a) where
    yesno (Just _) = True
    yesno Nothing = False
instance YesNo (Tree a) where
    yesno EmptyTree = False
    yesno _ = True
instance YesNo TrafficLight where
    yesno Red = False
    yesno _ = True

instance Functor Tree where
        fmap f EmptyTree = EmptyTree
        fmap f (Node a leftsub rightsub) = Node (f a) (fmap f leftsub) (fmap f rightsub)
