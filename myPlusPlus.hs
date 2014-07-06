myPlusPlus l1 l2 | null l1 = l2
myPlusPlus l1 l2 = myPlusPlus (init l1) ((last l1):l2)
