# Лабораторная работа 1. Проект Эйлера

Вариант: 1, 30

Автор: Голиков Андрей Сергеевич P34092 335126

Цель: освоить базовые приёмы и абстракции функционального программирования: функции, поток управления и поток данных, сопоставление с образцом, рекурсия, свёртка, отображение, работа с функциями как с данными, списки.

## Условие

### Задача 1:
If we list all the natural numbers below $10$ that are multiples of $3$ or $5$, we get $3$, $5$, $6$ and $9$. The sum of these multiples is $23$.

Find the sum of all the multiples of $3$ or $5$ below $1000$.

### Задача 30
Surprisingly there are only three numbers that can be written as the sum of fourth powers of their digits:

$$1634 = 1^4 + 6^4 + 3^4 + 4^4$$

$$8208 = 8^4 + 2^4 + 0^4 + 8^4$$

$$9474 = 9^4 + 4^4 + 7^4 + 4^4$$

As $1 = 1^4$ is not a sum it is not included.

The sum of these numbers is $1634 + 8208 + 9474 = 19316$.

Find the sum of all the numbers that can be written as the sum of fifth powers of their digits.

## Реализация

Полный код различных реализаций представлен в `src`. Ниже продемонстрированы куски, явно использующие необходимые подходы

### Различные реализации задания 1

Служебная функция `maybeGet` валидирует число и возвращает либо его, либо 0:

```haskell
cond :: Int -> Bool
cond x = x `mod` 3 == 0 || x `mod` 5 == 0

maybeGet :: Int -> Int
maybeGet x = if cond x then x else 0
```

- Рекурсия:

```haskell
recursion :: Int -> Int
recursion finish = recursion' 1
  where
    recursion' :: Int -> Int
    recursion' x
      | x == finish = 0
      | otherwise = maybeGet x + recursion' (x + 1)
```

- Хвостовая рекурсия:

```haskell
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
```

- Реализация с явным разделением на генерацию, фильтрацию и свертку:

```haskell
modul :: Int -> Int
modul finish = sum filtered
  where
    filtered = filter cond list
    list = [1 .. finish - 1]
```
- Реализация при помощи `map`:

```haskell
mapped :: Int -> Int
mapped finish = sum $ map maybeGet [1 .. finish - 1]
```
- Реализация с использованием бесконечных списков:

```haskell
infinity :: Int -> Int
infinity finish = sum $ map maybeGet $ take (finish - 1) [1 ..]
```

- Реализация на языке `C`:

```c
uint64_t euler(int finish) {
    uint64_t ans;
    for (uint64_t i = 1; i < finish; ++i) {
        if (i % 3 == 0 || i % 5 == 0) ans += i;
    }
    return ans;
}
```

### Различные реализации задания 30

Служебные функции для поиска максимального возможного числа, разбиения числа на цифры и поиска суммы 5 степеней цифр числа соответственно:

```haskell
limit :: Int
limit = fst $ head $ dropWhile snd $ map (\x -> (10 ^ x, 9 ^ (5 :: Int) * x > 10 ^ x)) [(1 :: Int) ..]

digits :: Int -> [Int]
digits 0 = []
digits x = (x `mod` 10) : digits (x `div` 10)

sumOfDigits :: Int -> Int
sumOfDigits x = sum $ map (^ (5 :: Int)) $ digits x
```

- Рекурсия:

```haskell
recursion :: Int
recursion = recursion' 2
  where
    recursion' :: Int -> Int
    recursion' x
      | x == limit = 0
      | x == sumOfDigits x = x + recursion' (x + 1)
      | otherwise = recursion' (x + 1)
```

- Хвостовая рекурсия:

```haskell
tailrec :: Int
tailrec = tailrec' 2 0
  where
    tailrec' :: Int -> Int -> Int
    tailrec' x acc
      | x == limit = acc
      | x == sumOfDigits x = tailrec' (x + 1) (x + acc)
      | otherwise = tailrec' (x + 1) acc
```

- явное разделение на генерацию, фильтрацию и свертку

```haskell
modul :: Int
modul = sum filtered
  where
    filtered = filter (\x -> x == sumOfDigits x) list
    list = [2 .. limit]
```

- Реализация с использованием бесконечных списков

```haskell
infinity :: Int
infinity = sum $ filter (\x -> x == sumOfDigits x) $ takeWhile (<= limit) [2 ..]
```

- Реализация на языке `Python`:

```python
def sum_of_digits(x):
    sum = 0
    for c in str(x):
        sum += int(c)**5
    return sum

i = 1
while (9**5*i >= 10**i): i +=1
limit = 10**i
euler = sum([x for x in range(2, limit) if x == sum_of_digits(x)])

print(euler)
```

### Вывод

Довольно прикольно получилось, мне понравилось. Так вышло, что нехвостовую рекурсию я писал после хвостовой и она показалась уже какой-то искусственной, Да и вообще все методы после первого уже не так чтоб естественно получались. Могу сказать, что самый интуитивный и простой для написани как раз оказался рекурсивный метод, самый читаемый, наверное, способ с отображением/фильтрацией списка. Бесконечные списки кажутся мощным инструментом, но конкретно в этих задачах нужны не оказались.
