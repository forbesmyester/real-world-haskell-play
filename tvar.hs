{-# LANGUAGE GeneralizedNewtypeDeriving #-}

import Control.Concurrent.STM
import Control.Monad

data Monster h p = Monster Int Int deriving (Show,Eq,Ord)


theMonster :: Int -> Int -> STM (TVar (Monster Int Int))
theMonster h p = newTVar (Monster h p)

attack = do
        m0 <- theMonster 10 8
        m1 <- theMonster 8 10
        return m1

-- theMonster :: TVar Int -> TVar Int -> Monster (TVar Int) (TVar Int)
-- theMonster = Monster

-- createTheMonster = do
--         h <- newTVar 10
--         p <- newTVar 8
--         return theMonster h p

data Item = Scroll
          | Wand
          | Banjo
            deriving (Eq, Ord, Show)

newtype Gold = Gold Int
    deriving (Eq, Ord, Show, Num)

newtype HitPoint = HitPoint Int
    deriving (Eq, Ord, Show, Num)

type Inventory = TVar [Item]
type Health = TVar HitPoint
type Balance = TVar Gold

data Player = Player {
      balance :: Balance,
      health :: Health,
      inventory :: Inventory
    }

basicTransfer qty fromBal toBal = do
  fromQty <- readTVar fromBal
  toQty   <- readTVar toBal
  writeTVar fromBal (fromQty - qty)
  writeTVar toBal   (toQty + qty)
