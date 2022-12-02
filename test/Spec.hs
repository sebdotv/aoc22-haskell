import Common
import Control.Monad.IO.Class (liftIO)
import Day01
import Day02
import Test.Hspec
import Text.Printf

main :: IO ()
main = hspec $ do
  testDay "01" Day01.solveP1 24000 70613 Day01.solveP2 45000 205805
  testDay "02" Day02.solveP1 15 11386 Day02.solveP2 12 13600
  where
    readLines name = lines <$> readFile name

    testDay day solver1 solutionExample1 solutionInput1 solver2 solutionExample2 solutionInput2 = do
      describe (printf "day %s P1" day) $ do
        testPart solver1 day solutionExample1 solutionInput1
      describe (printf "day %s P2" day) $ do
        testPart solver2 day solutionExample2 solutionInput2

    testPart solver day solutionExample solutionInput = do
      it "works for example" $ test solver (printf "./data/%s-example.txt" day) solutionExample
      it "works for input" $ test solver (printf "./data/%s-input.txt" day) solutionInput

    test :: Common.Solver -> String -> Int -> IO ()
    test solver file solution = do
      ex0in <- liftIO (solver <$> readLines file)
      ex0in `shouldBe` solution
