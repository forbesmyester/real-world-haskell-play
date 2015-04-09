
import System.Random

threeCoins :: StdGen -> (Bool, Bool, Bool)
threeCoins stdGen = let (c0, g1) = random stdGen
                        (c1, g2) = random g1 
                        (c2, _) = random g2
                    in (c0, c1, c2)
