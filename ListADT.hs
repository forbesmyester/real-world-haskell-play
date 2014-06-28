data List a = Cons a (List a)
	| Nil
	deriving (Show)

fromList (Cons a Nil) = a:[]
fromList (Cons a b) = a:fromList b
