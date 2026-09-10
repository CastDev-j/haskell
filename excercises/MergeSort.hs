module MergeSort where

mergeSort :: Ord a => [a] -> [a]
mergeSort [] = []
mergeSort [x] = [x]
mergeSort xs = merge (mergeSort left) (mergeSort right)
  where
    (left, right) = splitAt (length xs `div` 2) xs

merge :: Ord a => [a] -> [a] -> [a]
merge [] ys = ys
merge xs [] = xs
merge (x:xs) (y:ys)
  | x <= y    = x : merge xs (y:ys)
  | otherwise = y : merge (x:xs) ys

main :: IO ()
main = do
  let lista = [38, 27, 43, 3, 9, 82, 10]
  putStrLn ("Lista original: " ++ show lista)
  putStrLn ("Lista ordenada: " ++ show (mergeSort lista))
