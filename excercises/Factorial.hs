module Factorial where

factorial :: Integer -> Integer
factorial 0 = 1
factorial n = n * factorial (n - 1)

main :: IO ()
main = do
  let value = 4
  putStrLn ("Factorial de " ++ show value ++ ": " ++ show (factorial value))
