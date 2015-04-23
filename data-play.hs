
data MyBob a b c = ABob b | BBob a b | CBob a b c deriving (Show)

extractBob :: MyBob a a a -> [a]
extractBob (BBob a b) = [a, b]
extractBob (ABob a) = [a]
extractBob (CBob a b c) = [a, b, c]
