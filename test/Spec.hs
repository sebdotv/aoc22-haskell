import Control.Monad.IO.Class (liftIO)
import Day01
import Day02
import Test.Hspec

main :: IO ()
main = hspec $ do
  describe "day01 P1" $ do
    it "works for example" $ do
      ex0in <- liftIO (Day01.solveP1 <$> readLines "./data/01example.txt")
      ex0in `shouldBe` 24000
    it "works for input" $ do
      ex0in <- liftIO (Day01.solveP1 <$> readLines "./data/01input.txt")
      ex0in `shouldBe` 70613
  describe "day01 P2" $ do
    it "works for example" $ do
      ex0in <- liftIO (Day01.solveP2 <$> readLines "./data/01example.txt")
      ex0in `shouldBe` 45000
    it "works for input" $ do
      ex0in <- liftIO (Day01.solveP2 <$> readLines "./data/01input.txt")
      ex0in `shouldBe` 205805
  describe "day02 P1" $ do
    it "works for example" $ do
      ex0in <- liftIO (Day02.solveP1 <$> readLines "./data/02example.txt")
      ex0in `shouldBe` 15
    it "works for input" $ do
      ex0in <- liftIO (Day02.solveP1 <$> readLines "./data/02input.txt")
      ex0in `shouldBe` 11386
  describe "day02 P2" $ do
    it "works for example" $ do
      ex0in <- liftIO (Day02.solveP2 <$> readLines "./data/02example.txt")
      ex0in `shouldBe` 12
    it "works for input" $ do
      ex0in <- liftIO (Day02.solveP2 <$> readLines "./data/02input.txt")
      ex0in `shouldBe` 13600
  where
    readLines name = lines <$> readFile name
