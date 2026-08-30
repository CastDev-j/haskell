module Main where

main :: Prelude.IO ()
main = do
  putStrLn "Hello, everybody!"
  putStr ("Please look at my favorite odd numbers: " ++ show (filter odd [10 .. 20]))
