import Common
import Control.Monad.IO.Class (liftIO)
import Day01
import Day02
import Day03
import Day04
import Day05
import Day06
import Test.Hspec
import Text.Printf

main :: IO ()
main = hspec $ do
  --  testDay "00" Day00.solveP1 undefined undefined Day00.solveP2 undefined undefined
  testDay "01" Day01.solveP1 24000 70613 Day01.solveP2 45000 205805
  testDay "02" Day02.solveP1 15 11386 Day02.solveP2 12 13600
  testDay "03" Day03.solveP1 157 7875 Day03.solveP2 70 2479
  testDay "04" Day04.solveP1 2 569 Day04.solveP2 4 936
  testDay "05" Day05.solveP1 "CMZ" "MQTPGLLDN" Day05.solveP2 "MCD" "LVZPSTTCZ"
  testDay "06" Day06.solveP1 [7, 5, 6, 10, 11] [1723] Day06.solveP2 [19, 23, 23, 29, 26] [3708]
  where
    readLines name = lines <$> readFile name

    testDay day solver1 solutionExample1 solutionInput1 solver2 solutionExample2 solutionInput2 = parallel $ do
      describe (printf "day %s P1" day) $ do
        testPart solver1 day solutionExample1 solutionInput1
      describe (printf "day %s P2" day) $ do
        testPart solver2 day solutionExample2 solutionInput2

    testPart solver day solutionExample solutionInput = do
      it "works for example" $ test solver (printf "./data/%s-example.txt" day) solutionExample
      it "works for input" $ test solver (printf "./data/%s-input.txt" day) solutionInput

    test :: (HasCallStack, Show a, Eq a) => Common.GenericSolver a -> String -> a -> IO ()
    test solver file solution = do
      ex0in <- liftIO (solver <$> readLines file)
      ex0in `shouldBe` solution
