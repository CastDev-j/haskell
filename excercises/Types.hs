module Main where

main :: Prelude.IO ()
main = do
  let variable :: Int
      variable = 10

  let y :: Int
      y = 1

  putStrLn ("The value of variable is: " ++ show variable ++ " and the value of y is: " ++ show y)

  let biggestInt, smallestInt :: Int
      smallestInt = minBound
      biggestInt = maxBound

  putStrLn ("The biggest integer is: " ++ show biggestInt)
  putStrLn ("The smallest integer is: " ++ show smallestInt)

  let reallyBigInt :: Integer
      reallyBigInt = 1234567890123456789012345678901234567890

  putStrLn ("The really big integer is: " ++ show reallyBigInt)

  let d1, d2 :: Double
      d1 = 3.14159
      d2 = 2.71828

  putStrLn ("The value of d1 is: " ++ show d1 ++ " and the value of d2 is: " ++ show d2)

  let b1, b2 :: Bool
      b1 = True
      b2 = False

  putStrLn ("The value of b1 is: " ++ show b1 ++ " and the value of b2 is: " ++ show b2)

  let c1, c2 :: Char
      c1 = 'A'
      c2 = 'B'

  putStrLn ("The value of c1 is: " ++ show c1 ++ " and the value of c2 is: " ++ show c2)

  let s1, s2 :: String
      s1 = "Hello"
      s2 = "World"

  putStrLn ("The value of s1 is: " ++ show s1 ++ " and the value of s2 is: " ++ show s2)

  let t1, t2 :: (Int, String)
      t1 = (1, "one")
      t2 = (2, "two")

  putStrLn ("The value of t1 is: " ++ show t1 ++ " and the value of t2 is: " ++ show t2)

  let exp01 = True && False
      exp02 = True || False
      exp03 = not True
      exp04 = ('a' == 'a')
      exp05 = (16 /= 3)
      exp06 = (5 > 3) && ('p' <= 'q')
      exp07 = "Haskell" > "C++"

  putStrLn ("The value of exp01 is: " ++ show exp01)
  putStrLn ("The value of exp02 is: " ++ show exp02)
  putStrLn ("The value of exp03 is: " ++ show exp03)
  putStrLn ("The value of exp04 is: " ++ show exp04)
  putStrLn ("The value of exp05 is: " ++ show exp05)
  putStrLn ("The value of exp06 is: " ++ show exp06)
  putStrLn ("The value of exp07 is: " ++ show exp07)

  let sumatorial :: Integer -> Integer
      sumatorial 0 = 0
      sumatorial n = n + sumatorial (n - 1)

  putStrLn ("The sumatorial of 5 is: " ++ show (sumatorial 5))