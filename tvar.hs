
import Control.Concurrent.STM

data Monster h p = Monster Int Int

theMonster :: STM (TVar (Monster Int Int))
theMonster = newTVar (Monster 10 10)

monsterAlive :: STM Bool
monsterAlive = do
        (Monster health _) <- readTVar theMonster
        return (health > 0)
