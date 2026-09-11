validarCodigo :: Int -> Bool
validarCodigo numero = 
        numero > 0 && length (show numero) == 8 && 
        periodoCorrecto (obtenerPeriodo numero) &&
        categoriaCorrecto (obtenerCategoria numero) &&
        consecutivoCorrecto (obtenerConsecutivo numero)


obtenerPeriodo :: Int -> Int
obtenerPeriodo numero = numero `div` 100000

periodoCorrecto :: Int -> Bool
periodoCorrecto periodo =
        periodo == 262 ||
        (periodoA >= 27 && periodoA <= 29 &&
        (periodoB == 1 || periodoB == 2))
    where
        periodoA = periodo `div` 10
        periodoB = periodo `mod` 10

convertirPeriodo :: Int -> String
convertirPeriodo periodo = "20" ++ show (periodo `div` 10) ++ "-" ++ show (periodo `mod` 10)


obtenerCategoria :: Int -> Int
obtenerCategoria numero = (numero `mod` 100000) `div` 1000

categoriaCorrecto :: Int -> Bool
categoriaCorrecto categoria = categoria >= 1 && categoria <= 99

esDivisor :: Int -> Int -> Bool
esDivisor numero divisor = numero `mod` divisor == 0

divisores :: Int -> [Int]
divisores numero = filter (esDivisor numero) [1..numero-1]

suma :: Int -> Int
suma numero = sum (divisores numero)

asignarCategoria :: Int -> String
asignarCategoria numero
    | suma numero > numero = "Administrative"
    | suma numero == numero = "Engineering"
    | otherwise = "Humanities"


obtenerConsecutivo :: Int -> Int
obtenerConsecutivo numero = numero `mod` 1000

consecutivoCorrecto :: Int -> Bool
consecutivoCorrecto consecutivo = consecutivo >= 1 && consecutivo <= 999

conversionConsecutivo :: Int -> String
conversionConsecutivo numero = "num" ++ show numero

paroimpar :: Int -> String
paroimpar numero =
    if numero `mod` 2 == 0
        then "even"
        else "odd"


main :: IO()
main = do
    putStrLn "Ingresa el codigo: "
    entrada <- getLine
    
    let numero = read entrada :: Int
    
    if validarCodigo numero
        then putStrLn (unwords
             [ convertirPeriodo (obtenerPeriodo numero)
             , asignarCategoria (obtenerCategoria numero)
             , conversionConsecutivo (obtenerConsecutivo numero)
             , paroimpar numero])
        else putStrLn "Codigo invalido"
