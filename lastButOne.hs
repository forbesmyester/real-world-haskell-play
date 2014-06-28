lastButOne xs = if length xs <= 2
                then head xs
                else lastButOne ( tail xs )

lastButOneGuarded xs | length xs <= 2 = head xs
lastButOneGuarded xs = lastButOne (tail xs)
