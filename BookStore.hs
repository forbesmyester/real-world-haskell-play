data BookInfo = Book Int String [String]
                deriving (Show)

type CardHolder = String
type CardNumber = String
type Address = [String]
type CustomerID = Int

data BillingInfo = CreditCard CardNumber CardHolder Address
                 | CashOnDelivery
                 | Invoice CustomerID
                   deriving (Show)

data Customer = Customer {
	customerID       :: CustomerID,
	customerName     :: String,
	customerAddress  :: Address
} deriving (Show)

-- data Maybe a = Just a
--                | Nothing
