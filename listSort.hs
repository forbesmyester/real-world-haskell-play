import Data.List (sortBy)

orderingListLength a b | a<b = LT
orderingListLength a b | a>b = GT
orderingListLength _ _ = EQ

orderListOfLists a = sortBy orderingListLength a
