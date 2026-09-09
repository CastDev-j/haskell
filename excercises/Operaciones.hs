module Main where

main :: Prelude.IO ()
main = do
  let entero :: Int
      entero = 13
  let flotante :: Double
      flotante = 2.0

  let divisionNormal = fromIntegral entero / flotante
  let divisionRara = entero `div` floor flotante
  let suma = entero + floor flotante
  let resta = entero - floor flotante
  let multiplicacion = entero * floor flotante

  putStrLn ("Entero: " ++ show entero)
  putStrLn ("Flotante: " ++ show flotante)
  putStrLn ("Suma: " ++ show suma)
  putStrLn ("Resta: " ++ show resta)
  putStrLn ("Multiplicacion: " ++ show multiplicacion)
  putStrLn ("DivisionRara: " ++ show divisionRara)
  putStrLn ("DivisionNormal: " ++ show divisionNormal)

  let funcionSuma :: Int -> Int -> Int
      funcionSuma x y
        | x == 2 = x + y + 20
        | otherwise = x + y

  putStrLn ("Sumando " ++ show (2 `funcionSuma` 20))
  putStrLn ("Sumando " ++ show (funcionSuma 3 20))
