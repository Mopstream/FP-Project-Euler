import Data.Text as T
import Data.Text.IO as TIO
import qualified Prob1 as P1
import qualified Prob30 as P30

main :: IO ()
main = do
  TIO.putStrLn "Project Euler Prob 1 start testing"
  assertEquals (P1.tailrec 1000, 233168) "Хвостовая рекурсия"
  assertEquals (P1.recursion 1000, 233168) "Нехвостовая рекурсия"
  assertEquals (P1.modul 1000, 233168) "Модульная реализация"
  assertEquals (P1.mapped 1000, 233168) "Отображение"
  assertEquals (P1.infinity 1000, 233168) "Бесконечный список"
  TIO.putStrLn $ "end\n"

  TIO.putStrLn "Project Euler Prob 30 start testing"
  assertEquals (P30.tailrec, 443839) "Хвостовая рекурсия"
  assertEquals (P30.recursion, 443839) "Нехвостовая рекурсия"
  assertEquals (P30.modul, 443839) "Модульная реализация"
  assertEquals (P30.infinity, 443839) "Бесконечный список"
  TIO.putStrLn "end\n"

assertEquals :: (Eq a) => (a, a) -> T.Text -> IO ()
assertEquals (a, b) testDesc =
  TIO.putStrLn $ (if a == b then "Passed: " else "Failed: ") <> testDesc
