myConcatWorker a b r | (null a) && (null b) = r
myConcatWorker a b r | null a = myConcatWorker b [] r
myConcatWorker a b r = myConcatWorker (tail a) b (head(a):r)

myConcat ([a b]) = myConcatWorker a b []
