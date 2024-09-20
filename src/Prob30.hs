module Prob30
  ( recursion,
    tailrec,
    modul,
    infinity,
  )
where

limit :: Int
limit = fst $ head $ dropWhile snd $ map (\x -> (10 ^ x, 9 ^ (5 :: Int) * x > 10 ^ x)) [(1 :: Int) ..]

digits :: Int -> [Int]
digits 0 = []
digits x = (x `mod` 10) : digits (x `div` 10)

sumOfDigits :: Int -> Int
sumOfDigits x = sum $ map (^ (5 :: Int)) $ digits x

recursion :: Int
recursion = (recursion' 2)
  where
    recursion' :: Int -> Int
    recursion' x
      | x == limit = 0
      | x == sumOfDigits x = x + recursion' (x + 1)
      | otherwise = recursion' (x + 1)

tailrec :: Int
tailrec = tailrec' 2 0
  where
    tailrec' :: Int -> Int -> Int
    tailrec' x acc
      | x == limit = acc
      | x == sumOfDigits x = tailrec' (x + 1) (x + acc)
      | otherwise = tailrec' (x + 1) acc

modul :: Int
modul = sum filtered
  where
    filtered = filter (\x -> x == sumOfDigits x) list
    list = [2 .. limit]

infinity :: Int
infinity = sum $ filter (\x -> x == sumOfDigits x) $ takeWhile (<= limit) [2 ..]
