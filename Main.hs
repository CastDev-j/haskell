module Main where

main :: IO ()
main = do
  let listOne = [1 .. 10]
  let listTwo = [3, 6 .. 30]

  let multipliedList = [x * y | x <- listOne, y <- listTwo]

  let otherForm = zipWith (*) listOne listTwo

  putStrLn ("Lista uno: " ++ show listOne)
  putStrLn ("Lista dos: " ++ show listTwo)
  putStrLn ("Lista multiplicada: " ++ show multipliedList)
  putStrLn ("Otra forma: " ++ show otherForm)