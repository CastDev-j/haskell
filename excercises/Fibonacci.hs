module Fibonacci where

fibonacci :: Int -> Integer
fibonacci 0 = 0
fibonacci 1 = 1
fibonacci n = fibonacci (n - 1) + fibonacci (n - 2)

main :: IO ()
main = do
  let value = 10
  putStrLn ("Fibonacci de " ++ show value ++ ": " ++ show (fibonacci value))
