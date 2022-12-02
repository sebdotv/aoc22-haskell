import Common
import Control.Monad.IO.Class (liftIO)
import Day01
import Day02
import Test.Hspec
import Text.Printf

main :: IO ()
main = hspec $ do
  describe "day01 P1" $ do
    testPart Day01.solveP1 "01" 24000 70613
  describe "day01 P2" $ do
    testPart Day01.solveP2 "01" 45000 205805
  describe "day02 P1" $ do
    testPart Day02.solveP1 "02" 15 11386
  describe "day02 P2" $ do
    testPart Day02.solveP2 "02" 12 13600
  where
    readLines name = lines <$> readFile name

    testPart solver day solutionExample solutionInput = do
      it "works for example" $ test solver (printf "./data/%s-example.txt" day) solutionExample
      it "works for input" $ test solver (printf "./data/%s-input.txt" day) solutionInput

    test :: Common.Solver -> String -> Int -> IO ()
    test solver file solution = do
      ex0in <- liftIO (solver <$> readLines file)
      ex0in `shouldBe` solution
