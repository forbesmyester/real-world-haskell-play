nodesAreSame :: a -> b -> Maybe a
nodesAreSame a b | a == b = Just a
nodesAreSame a b = Nothing
