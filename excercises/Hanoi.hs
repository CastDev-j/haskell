module Hanoi where

type Movimiento = (Int, Int, Int)

hanoi :: Int -> Int -> Int -> Int -> [Movimiento]
hanoi 0 _ _ _ = []
hanoi n desde hacia aux = hanoi (n - 1) desde aux hacia ++ [(n, desde, hacia)] ++ hanoi (n - 1) aux hacia desde

main :: IO ()
main = do
  let n = 3
  let movimientos = hanoi n 1 3 2
  putStrLn ("Torres de Hanoi con " ++ show n ++ " discos:")
  mapM_ (\(d, f, t) -> putStrLn ("  Mover disco " ++ show d ++ " de " ++ show f ++ " a " ++ show t)) movimientos
  putStrLn ("Total de movimientos: " ++ show (length movimientos))
