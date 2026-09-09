{-
====================================================================================
  doc.hs — TODO SOBRE HASKELL (guía de estudio con ejemplos ejecutables)
====================================================================================

  CÓMO USARLO
  ---------------------------------------------------------------
  * Cargar en el REPL (recomendado para explorar tipos y funciones):
        ghci doc.hs
      Comandos útiles dentro de GHCi:
        :t expresion      -> muestra el tipo de una expresion
        :i  funcion       -> informacion de una funcion
        :i  Eq            -> informacion de una clase de tipos
        :browse           -> lista todas las definiciones cargadas
        :r                -> recarga el archivo tras editarlo
        :q                -> sale

  * Ejecutar el demo principal (imprime ejemplos):
        runghc doc.hs

  * Probar una funcion concreta sin main (dentro de GHCi):
        esPar 42
        areaRectangulo 4.5 3.0
        miFactorial 6

  * Para integrarlo con cabal se puede anadir al .cabal:

        executable doc
          main-is:          doc.hs
          build-depends:    base ^>= 4.20
          default-language: Haskell2010

      y luego:  cabal run doc
====================================================================================
-}

-- ====================================================================================
-- 1. FUNDAMENTOS DE HASKELL
-- ====================================================================================
--  * Funcional PURO:  las funciones NO tienen efectos secundarios; con los mismos
--    argumentos siempre devuelven el mismo resultado. Una funcion es una "caja" que
--    transforma una entrada en una salida, como en matematicas.
--  * PEReZOSO (lazy):  las expresiones solo se evaluan cuando hace falta. Esto permite
--    trabajar con listas infinitas (ver seccion de lasitud).
--  * Tipado ESTATICO y FUERTE:  cada expresion tiene un tipo conocido en tiempo de
--    compilacion y el compilador evita mezclar tipos incompatibles.
--  * Inferencia de tipos:  no siempre hay que escribir el tipo; GHC puede deducirlo.
--  * Sin variables mutables ni bucles for/while:  se reemplazan por recursividad y
--    funciones de orden superior (map, filter, fold...).

-- ====================================================================================
-- 2. COMENTARIOS
-- ====================================================================================
-- Un comentario de linea empieza con dos guiones.
-- Un comentario de bloque va entre llaves con guiones, por ejemplo:

-- {-
--   Esto es un comentario de bloque.
--   Puede ocupar varias lineas.
-- -}

-- ====================================================================================
-- 3. TIPOS BÁSICOS
-- ====================================================================================
-- La anotacion de tipo se escribe con '::'  (se lee "es de tipo").

-- Int      : entero con tope fijo (depende de la arquitectura).
maximoInt, minimoInt :: Int
maximoInt = maxBound
minimoInt = minBound

-- Integer  : entero de tamano arbitrario (no se desborda nunca).
numeroGigante :: Integer
numeroGigante = 1234567890123456789012345678901234567890

-- Double / Float : numeros con decimales. Double tiene mas precision.
piAproximado :: Double
piAproximado = 3.141592653589793

-- Bool   : True o False
-- Char   : un solo caracter entre comillas simples
letra :: Char
letra = 'A'

-- String : una cadena de texto = [Char]  (lista de caracteres)
saludo :: String
saludo = "Hola Haskell"

-- Tupla  : pareja (o trio, etc.) de valores, posiblemente de tipos distintos.
pareja :: (Int, String)
pareja = (7, "siete")

-- Lista  : coleccion de valores TODOS del mismo tipo.
numeros :: [Int]
numeros = [1, 2, 3, 4, 5]

-- NOTA: 1. Convertir enteros a decimales con fromIntegral (ver seccion de aritmetica).
--       2. show convierte cualquier cosa mostrable en String.

-- ====================================================================================
-- 4. DEFINIR FUNCIONES
-- ====================================================================================

-- La firma de tipo primero; luego las ecuaciones.
--   doble :: Int -> Int   significa "recibe un Int y devuelve un Int".
doble :: Int -> Int
doble x = x * 2

-- Currying:  miSuma :: Int -> Int -> Int es en realidad  Int -> (Int -> Int).
-- Recibe el primer argumento y devuelve OTRA FUNCION que espera el segundo.
miSuma :: Int -> Int -> Int
miSuma a b = a + b

-- Aplicacion parcial: convertir "miSuma" en una funcion que recibe un solo argumento.
sumaDiez :: Int -> Int
sumaDiez = miSuma 10          -- equivale a: sumarDiez x = 10 + x

-- Operador infijo entre acentos graves (backticks); se lee como verbo.
esDivisiblePor :: Int -> Int -> Bool
esDivisiblePor a b = a `rem` b == 0

-- Aplicacion con $  (evita parentesis):  f $ x == f (x)
conDolar :: Int
conDolar = doble $ 3 + 4       -- equivale a doble (3 + 4)

-- Composicion con . :  (f . g) x == f (g x)
dobleYSumaUno :: Int -> Int
dobleYSumaUno = (+ 1) . doble  -- primero doble, luego +1

-- ====================================================================================
-- 5. ARITMÉTICA Y OPERADORES
-- ====================================================================================
--  Asociatividad:  + * -  son asociativos a la izquierda;  ^  a la derecha.
--  Precedencia:  ^  >  * / rem div mod  >  + -   >  == < >  >  &&  >  ||
--
--  Operadores con enteros:  +  -  *  div  mod  rem  quot  ^
--  Con decimales:           +  -  *  /   **    (div y mod son SOLO enteros)
--  Comparacion:      ==  /=  <  >  <=  >=
--  Logicos:          &&  ||  not

-- div  : division entera hacia abajo (trunca el resto hacia -infinito)
-- rem  : resto asociado a div   (a = (a div b)*b + (a rem b))
-- quot : division entera hacia cero
-- mod  : resto asociado a quot
ejemploDiv, ejemploRem, ejemploMod :: Int
ejemploDiv = 7  `div` 2   -- 3
ejemploRem = 7  `rem` 2   -- 1
ejemploMod = (-7) `mod` 2 -- 1   (porque (-7) div 2 == -4, y -4*2+1 = -7)

-- Mezclar enteros y decimales exige conversion explicita:
mezcla :: Double
mezcla = fromIntegral 7 / 2.0   -- 3.5

-- ====================================================================================
-- 6. PATTERN MATCHING (coincidencia de patrones)
-- ====================================================================================
-- Se definen varias ecuaciones; Haskell prueba de arriba hacia abajo.

esCero :: Int -> Bool
esCero 0 = True            -- patron literal
esCero _ = False           -- _ coincide con cualquier cosa (se ignora)

primerElemento :: [Int] -> Int
primerElemento (x : _) = x  -- patron cons (x es la cabeza, la cola se ignora)

-- 'undefined' representa un valor no definido; se usa aqui para casos imposibles.
clasificaLista :: [Int] -> String
clasificaLista []     = "lista vacia"
clasificaLista [x]    = "un solo elemento: " ++ show x
clasificaLista (x:y:_) = "al menos dos elementos: " ++ show x ++ ", " ++ show y

-- ====================================================================================
-- 7. GUARDAS (guardas / guards)
-- ====================================================================================
clasificaNota :: Int -> String
clasificaNota nota
  | nota >= 9  = "Excelente"
  | nota >= 7  = "Bien"
  | nota >= 5  = "Regular"
  | otherwise  = "Reprobado"

-- otherwise es solo sinónimo de True.

-- ====================================================================================
-- 8. where / let / case
-- ====================================================================================

-- where  : definiciones locales al final de la ecuacion.
areaRectangulo :: Double -> Double -> Double
areaRectangulo base altura = base * altura
  where
    -- (no hace falta aqui, pero muestra la sintaxis)
    _ = 0

-- let ... in : expresion local.
areaRectangulo' :: Double -> Double -> Double
areaRectangulo' b a = let resultado = b * a in resultado

-- case ... of : ramas dentro de la propia expresion.
paridadTexto :: Int -> String
paridadTexto n = case even n of
  True  -> "par"
  False -> "impar"

-- ====================================================================================
-- 9. RECURSIVIDAD  (reemplaza a los bucles)
-- ====================================================================================

-- Factorial: n! = 1 * 2 * ... * n
miFactorial :: Int -> Int
miFactorial 0 = 1
miFactorial n = n * miFactorial (n - 1)

-- Suma de 1..n
miSumatoria :: Int -> Int
miSumatoria 0 = 0
miSumatoria n = n + miSumatoria (n - 1)

-- Fibonacci: 0, 1, 1, 2, 3, 5, 8, 13, ...
miFibonacci :: Int -> Int
miFibonacci 0 = 0
miFibonacci 1 = 1
miFibonacci n = miFibonacci (n - 1) + miFibonacci (n - 2)

-- Potencia:  x^n
miPotencia :: Int -> Int -> Int
miPotencia _ 0 = 1
miPotencia x n = x * miPotencia x (n - 1)

-- Longitud de una lista (sin usar Prelude.length)
miLongitud :: [a] -> Int
miLongitud []     = 0
miLongitud (_:xs) = 1 + miLongitud xs

-- Suma de todos los elementos de una lista
miSumaLista :: [Int] -> Int
miSumaLista []     = 0
miSumaLista (x:xs) = x + miSumaLista xs

-- Revertir una lista (sin usar reverse)
miReversa :: [a] -> [a]
miReversa []     = []
miReversa (x:xs) = miReversa xs ++ [x]

-- Filtrar los pares de una lista
soloPares :: [Int] -> [Int]
soloPares []     = []
soloPares (x:xs)
  | even x    = x : soloPares xs
  | otherwise = soloPares xs

-- ====================================================================================
-- 10. LISTAS
-- ====================================================================================

-- construlr con ( : )  y ( ++ )  (concatenar)
ejemploCons, ejemploAppend :: [Int]
ejemploCons   = 1 : 2 : 3 : []          -- [1,2,3]
ejemploAppend = [1, 2] ++ [3, 4]        -- [1,2,3,4]

-- Rangos (arithmetic sequences)
rango1, rango2, paresHasta :: [Int]
rango1 = [1 .. 10]       -- [1,2,...,10]
rango2 = [1, 3 .. 10]    -- paso 2: [1,3,5,7,9]
paresHasta = [2, 4 .. 20]

-- Funciones clasicas de Prelude sobre listas:
--   head  xs  -> primer elemento
--   tail  xs  -> todo menos el primero
--   init  xs  -> todo menos el ultimo
--   last  xs  -> ultimo elemento
--   length, null, sum, product, maximum, minimum, elem, reverse, take, drop
--   takeWhile, dropWhile, zip, union, nub ...

-- Listas infinitas (gracias a la pereza):
infinitosUnos :: [Int]
infinitosUnos = repeat 1

naturales :: [Int]
naturales = [1 ..]         -- no termina nunca; solo usar con take

primerosCincuentaPares :: [Int]
primerosCincuentaPares = take 50 [2, 4 ..]

-- List comprehensions (comprension de listas), similar a {x² | x∈N, par}
cuadradosParesHasta10 :: [Int]
cuadradosParesHasta10 = [x * x | x <- [1 .. 10], even x]
-- ^ resultado: [4,16,36,64,100]

-- ====================================================================================
-- 11. TUPLAS
-- ====================================================================================
-- Acceso a parejas:  fst (primer elemento),  snd (segundo elemento)
fst' :: (a, b) -> a
fst' (x, _) = x

snd' :: (a, b) -> b
snd' (_, y) = y

puntoMedio :: (Double, Double) -> (Double, Double) -> (Double, Double)
puntoMedio (x1, y1) (x2, y2) = ((x1 + x2) / 2, (y1 + y2) / 2)

-- zip une dos listas en una lista de parejas (se detiene en la mas corta).
zonasIguales :: [(Int, Int)]
zonasIguales = zip [1, 2, 3] [10, 20, 30]   -- [(1,10),(2,20),(3,30)]

-- ====================================================================================
-- 12. TIPOS ALGEBRAICOS (data)
-- ====================================================================================
-- 'data' define un tipo nuevo a partir de constructores.

-- Un tipo con varios constructores (como una enumeracion "con datos").
data Color = Rojo | Verde | Azul
  deriving (Show, Eq, Enum)   -- Show: poder imprimirlo; Eq: compararlo; Enum: [Rojo..]

data Direccion = Norte | Sur | Este | Oeste
  deriving (Show, Eq, Enum)

-- Constructores de datos pueden llevar campos (como "objetos" sin clases).
data Forma = Circulo Double          -- constructor con un campo: el radio
           | Rectangulo Double Double  -- constructor con dos campos
           | Cuadrado Double
  deriving (Show)

areaForma :: Forma -> Double
areaForma (Circulo r)        = pi * r * r
areaForma (Rectangulo b h)   = b * h
areaForma (Cuadrado l)       = l * l

-- Pueden ser recursivos, como la definicion de un arbol binario.
data Arbol a = Hoja a | Nodo (Arbol a) (Arbol a)
  deriving (Show)

ejemploArbol :: Arbol Int
ejemploArbol = Nodo (Hoja 1) (Nodo (Hoja 2) (Hoja 3))

-- 'deriving' agrega gratuitamente: Eq, Ord, Show, Read, Enum, Bounded.
--   Eq    : permite == y /=
--   Ord   : permite < > <= >= y max/min
--   Show  : permite show (convertir a String)
--   Read  : permite read (convertir desde String)
--   Enum  : permite [x .. y] y succ/pred
--   Bounded: permite minBound / maxBound

-- ====================================================================================
-- 13. TIPOS OPCIONALES: Maybe y Either
-- ====================================================================================
-- Maybe a  = Nothing  |  Just x    representa "puede fallar".
-- Either a b = Left a | Right b    representa "error o exito".

raiz, divisionSegura :: Double -> Double -> Maybe Double
raiz n
  | n < 0     = Nothing
  | otherwise = Just (sqrt n)

divisionSegura _ 0 = Nothing
divisionSegura a b = Just (a / b)

-- Un 'Either' para reportar errores descriptivos.
dividir :: Double -> Double -> Either String Double
dividir _ 0 = Left "Error: division por cero"
dividir a b = Right (a / b)

-- ====================================================================================
-- 14. POLIMORFISMO Y CLASES DE TIPOS (typeclasses)
-- ====================================================================================
-- Una 'a' minuscula es una variable de tipo (polimorfismo).
--  id :: a -> a
mismaIgualdad :: Eq a => a -> a -> Bool
mismaIgualdad x y = x == y

--  Eq a =>  dice "para CUALQUIER tipo a que tenga instancia de Eq".
--  Otras clases comunes:  Show, Read, Ord, Num, Enum, Bounded, Integral, Floating.

miDobleGenerico :: Num a => a -> a
miDobleGenerico x = x + x

promedio :: [Double] -> Double
promedio xs = miSumaListaReal xs / fromIntegral (miLongitud xs)

miSumaListaReal :: [Double] -> Double
miSumaListaReal []     = 0
miSumaListaReal (x:xs) = x + miSumaListaReal xs

-- ====================================================================================
-- 15. FUNCIONES DE ORDEN SUPERIOR (reciben/devuelven funciones)
-- ====================================================================================

-- map    aplica una funcion a cada elemento:   map f [x1,x2] = [f x1, f x2]
doblarLista :: [Int] -> [Int]
doblarLista xs = map doble xs

-- filter conserva los que cumplen la condicion.
numerosPares :: [Int] -> [Int]
numerosPares xs = filter even xs

-- foldr  /  foldl  /  foldl'  "pliegan" la lista acumulando.
--   foldr op base [a1,a2,a3] == a1 `op` (a2 `op` (a3 `op` base))
sumaConFold :: [Int] -> Int
sumaConFold xs = foldr (+) 0 xs

productoConFold :: [Int] -> Int
productoConFold xs = foldl (*) 1 xs

-- zipWith combina dos listas elemento a elemento.
sumaVectorial :: [Int] -> [Int] -> [Int]
sumaVectorial xs ys = zipWith (+) xs ys

-- concatMap = concat . map  (aplica y aplana las listas resultantes).
palabrasYLongitudes :: [String] -> [Int]
palabrasYLongitudes = concatMap (\p -> [length p, length p * 2])

-- Manejo elegante de Maybe con fmap :  fmap f (Just x) == Just (f x)
fmapEjemplo :: Maybe Int
fmapEjemplo = fmap (+ 1) (Just 5)   -- Just 6

-- ====================================================================================
-- 16. LAMBDAS (funciones anonimas)
-- ====================================================================================
--   \x -> expresion
soloTuplesPares :: [(Int, Int)] -> [(Int, Int)]
soloTuplesPares = filter (\(x, _) -> even x)

incrementarTodos :: [Int] -> [Int]
incrementarTodos = map (+ 1)         -- seccion de operador: (x + 1)

-- ====================================================================================
-- 17. SECCIONES DE OPERADores Y POINT-FREE
-- ====================================================================================
--  (2 *)  -> \x -> 2 * x
--  (* 2)  -> \x -> x * 2
--  (1 +)  -> \x -> 1 + x
--  (`div` 2) -> \x -> x `div` 2

-- Definiciones "point-free" (sin nombrar al argumento):
duplica :: Int -> Int
duplica = (* 2)

paridadOK :: Int -> Bool
paridadOK = even

-- ====================================================================================
-- 18. ENTRADA / SALIDA (IO)
-- ====================================================================================
-- Haskell puro obliga a marcar las acciones de IO con el tipo IO a.
-- Una funcion pura NUNCA puede hacer getLine / putStrLn; "devuelve" una accion IO.

saludoInteractivo :: IO ()
saludoInteractivo = do
  putStrLn "Como te llamas?"
  nombre <- getLine          -- <- "extrae" el valor de la accion IO
  putStrLn ("Hola, " ++ nombre ++ "!")

sumaDosNums :: IO ()
sumaDosNums = do
  putStrLn "Dame dos numeros enteros:"
  a <- readLn :: IO Int
  b <- readLn :: IO Int
  print (a + b)

leerEImprimirArchivo :: FilePath -> IO ()
leerEImprimirArchivo ruta = do
  contenido <- readFile ruta
  putStrLn contenido

-- Operador de encadenado:  accion >>= funcion   == do  x <- accion ; funcion x
-- Operador secuencia:      accion1 >> accion2   == ejecuta una y luego la otra.
-- La funcion 'return' NO es like de C; simplemente envuelve un valor puro en IO.

-- ====================================================================================
-- 19. MÓDULOS E IMPORTS
-- ====================================================================================
--  import Data.List          -- importa todo
--  import Data.List (sort)   -- solo sort
--  import Data.List qualified as L  -- L.sort
--  import Data.List hiding (sort)  -- todo menos sort
--  import Data.Char qualified as C  -- C.isDigit, C.toUpper ...
--  * Importar un modulo propio es igual, con el nombre del archivo minusculas opcionales.

-- ====================================================================================
-- 20. PEReZA: LISTAS INFINITAS EN ACCION
-- ====================================================================================
-- Como nada se evalúa hasta que se necesita, podemos pedir el elemento 1000
-- de una lista infinita sin calcular los demas.

fibonacciInfinito :: [Integer]
fibonacciInfinito = 0 : 1 : zipWith (+) fibonacciInfinito (tail fibonacciInfinito)

enésimoFibonacci :: Int -> Integer
enésimoFibonacci n = fibonacciInfinito !! n

-- Criba de Eratostenes con listas infinitas (ejemplo clasico).
criba :: [Integer] -> [Integer]
criba (p : xs) = p : criba [x | x <- xs, x `mod` p /= 0]

primos :: [Integer]
primos = criba [2 ..]

primerosNumerosPrimos :: Int -> [Integer]
primerosNumerosPrimos n = take n primos

-- ====================================================================================
-- 21. ALGUNOS PROBLEMAS CLÁSICOS RESUELTOS
-- ====================================================================================

-- Numero de elementos de una lista (propia, lista las funciones de arriba).
-- Mayor de dos sin maxBound:
mayorDeDos :: (Ord a) => a -> a -> a
mayorDeDos a b
  | a >= b = a
  | otherwise = b

-- Palindromo? (la palabra se lee igual al reves)
esPalindromo :: String -> Bool
esPalindromo s = s == reverse s

-- Cuenta cuantas veces aparece un elemento.
contarApariciones :: Eq a => a -> [a] -> Int
contarApariciones x xs = miLongitud [y | y <- xs, y == x]

-- Numeros perfectos hasta n (un numero igual a la suma de sus divisores propios).
sumaDivisores :: Int -> Int
sumaDivisores n = sum [d | d <- [1 .. n - 1], n `mod` d == 0]

esPerfecto :: Int -> Bool
esPerfecto n = n > 1 && sumaDivisores n == n

perfectosHasta :: Int -> [Int]
perfectosHasta n = [x | x <- [1 .. n], esPerfecto x]

-- ====================================================================================
-- 22. main (DEMO: ejecuta con runghc doc.hs)
-- ====================================================================================
main :: IO ()
main = do
  putStrLn "======================= DEMO DE haskell ======================="

  putStrLn "\n--- Tipos basicos ---"
  print minimoInt
  print maximoInt
  print numeroGigante
  print piAproximado
  print letra
  print saludo
  print pareja
  print numeros

  putStrLn "\n--- Funciones ---"
  print (doble 21)
  print (miSuma 3 4)
  print (sumaDiez 5)
  print (conDolar)
  print (dobleYSumaUno 5)
  print (10 `esDivisiblePor` 2)
  print esCero0
  print notEsCero

  putStrLn "\n--- Aritmetica ---"
  print (ejemploDiv, ejemploRem, ejemploMod)
  print mezcla
  print (2 ^ 10)

  putStrLn "\n--- Pattern matching y guardas ---"
  print (primerElemento [9, 8, 7])
  print (clasificaLista [5])
  print (clasificaLista [1, 2, 3])
  print (clasificaNota 8)
  print (clasificaNota 4)
  print (paridadTexto 12)

  putStrLn "\n--- Recursion ---"
  print (miFactorial 6)          -- 720
  print (miSumatoria 5)          -- 15
  print (miFibonacci 10)         -- 55
  print (miPotencia 2 8)         -- 256
  print (miLongitud [1, 2, 3])   -- 3
  print (miSumaLista [1 .. 5])   -- 15
  print (miReversa [1, 2, 3])    -- [3,2,1]
  print (soloPares [1 .. 10])    -- [2,4,6,8,10]

  putStrLn "\n--- Listas ---"
  print ejemploCons
  print ejemploAppend
  print rango1
  print rango2
  print paresHasta
  print (take 5 infinitosUnos)
  print (take 5 naturales)
  print primerosCincuentaPares
  print cuadradosParesHasta10

  putStrLn "\n--- Tuplas ---"
  print (fst' (1, "a"))
  print (snd' (1, "a"))
  print (puntoMedio (0, 0) (10, 10))
  print zonasIguales

  putStrLn "\n--- data ---"
  print Rojo
  print Azul
  print [Verde .. Azul]
  print (areaForma (Circulo 2.0))
  print (areaForma (Rectangulo 4.0 3.0))
  print (areaForma (Cuadrado 5.0))
  print ejemploArbol

  putStrLn "\n--- Maybe / Either ---"
  print (raiz 9.0)
  print (raiz (-4.0))
  print (divisionSegura 10 2)
  print (divisionSegura 10 0)
  print (dividir 10 2)
  print (dividir 10 0)
  print (case raiz 16.0 of {Just r -> r < 100; Nothing -> False})

  putStrLn "\n--- Polimorfismo ---"
  print (mismaIgualdad 3 3)
  print (miDobleGenerico 2.5)
  print (promedio [1, 2, 3, 4])

  putStrLn "\n--- Orden superior ---"
  print (doblarLista [1, 2, 3])
  print (numerosPares [1 .. 10])
  print (sumaConFold [1 .. 5])
  print (productoConFold [1 .. 6])
  print (sumaVectorial [1, 2, 3] [10, 20, 30])
  print (concatMap (\w -> [length w]) ["hola", "mundo"])

  putStrLn "\n--- Lambdas / secciones ---"
  print (soloTuplesPares [(1, 2), (3, 4), (2, 5), (4, 6)])
  print (incrementarTodos [1, 2, 3])
  print (duplica 7)

  putStrLn "\n--- Pereza / infinitas ---"
  print (take 12 fibonacciInfinito)
  print (enésimoFibonacci 20)
  print (take 10 primos)
  print (primerosNumerosPrimos 15)
  print (take 20 sincronizados)

  putStrLn "\n--- Problemas clasicos ---"
  print (mayorDeDos 7 3)
  print (esPalindromo "anilina")
  print (contarApariciones 'a' "banana")
  print (perfectosHasta 100)

  putStrLn "\n===================== FIN DEL DEMO ======================="

-- Variables auxiliares para el demo (evitan ambiguedades de tipos en GHCi).
esCero0, notEsCero :: Bool
esCero0   = esCero 0
notEsCero = esCero 5

sincronizados :: [Integer]
sincronizados = zipWith (+) naturalesEnteros [1000 ..]

naturalesEnteros :: [Integer]
naturalesEnteros = [1 ..]