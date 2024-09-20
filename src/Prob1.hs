module Prob1
  ( tailrec,
    recursion,
    modul,
    mapped,
    infinity,
  )
where

cond :: Int -> Bool
cond x = x `mod` 3 == 0 || x `mod` 5 == 0

maybeGet :: Int -> Int
maybeGet x = if cond x then x else 0

tailrec :: Int -> Int
tailrec finish = tailrec' 1 0
  where
    tailrec' :: Int -> Int -> Int
    tailrec' x acc
      | x == finish = acc
      | otherwise = tailrec' (x + 1) new_acc
      where
        new_acc :: Int
        new_acc = acc + maybeGet x

recursion :: Int -> Int
recursion finish = recursion' 1
  where
    recursion' :: Int -> Int
    recursion' x
      | x == finish = 0
      | otherwise = maybeGet x + recursion' (x + 1)

modul :: Int -> Int
modul finish = sum filtered
  where
    filtered = filter cond list
    list = [1 .. finish - 1]

mapped :: Int -> Int
mapped finish = sum $ map maybeGet [1 .. finish - 1]

infinity :: Int -> Int
infinity finish = sum $ map maybeGet $ take (finish - 1) [1 ..]
