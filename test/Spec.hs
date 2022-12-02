import Common
import Control.Monad.IO.Class (liftIO)
import Day01
import Day02
import Test.Hspec

main :: IO ()
main = hspec $ do
  describe "day01 P1" $ do
    it "works for example" $ test Day01.solveP1 "./data/01example.txt" 24000
    it "works for input" $ test Day01.solveP1 "./data/01input.txt" 70613
  describe "day01 P2" $ do
    it "works for example" $ test Day01.solveP2 "./data/01example.txt" 45000
    it "works for input" $ test Day01.solveP2 "./data/01input.txt" 205805
  describe "day02 P1" $ do
    it "works for example" $ test Day02.solveP1 "./data/02example.txt" 15
    it "works for input" $ test Day02.solveP1 "./data/02input.txt" 11386
  describe "day02 P2" $ do
    it "works for example" $ test Day02.solveP2 "./data/02example.txt" 12
    it "works for input" $ test Day02.solveP2 "./data/02input.txt" 13600
  where
    readLines name = lines <$> readFile name

    test :: Common.Solver -> String -> Int -> IO ()
    test solver file solution = do
      ex0in <- liftIO (solver <$> readLines file)
      ex0in `shouldBe` solution
