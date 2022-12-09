import Common (Solver, dayStr, exampleFile, inputFile, readLines)
import Control.Monad.IO.Class (liftIO)
import Ref
import Test.Hspec
import Text.Printf

main :: IO ()
main = hspec $ do
  foldr1 (>>) [testDay (dayStr (i + 1)) f1 se1 si1 f2 se2 si2 | (i, (f1, f2), (se1, si1, se2, si2)) <- zip3 [0 ..] Ref.solvers solutions]
  where
    solutions =
      [ ("24000", "70613", "45000", "205805"), -- 01
        ("15", "11386", "12", "13600"), -- 02
        ("157", "7875", "70", "2479"), -- 03
        ("2", "569", "4", "936"), -- 04
        ("CMZ", "MQTPGLLDN", "MCD", "LVZPSTTCZ"), -- 05
        ("[7,5,6,10,11]", "[1723]", "[19,23,23,29,26]", "[3708]"), -- 06
        ("95437", "1453349", "24933642", "2948823"), -- 07
        ("21", "", "", "") -- 08
      ]

    testDay day solver1 solutionExample1 solutionInput1 solver2 solutionExample2 solutionInput2 = parallel $ do
      describe (printf "day %s P1" day) $ do
        testPart solver1 day solutionExample1 solutionInput1
      describe (printf "day %s P2" day) $ do
        testPart solver2 day solutionExample2 solutionInput2

    testPart solver day solutionExample solutionInput = do
      it "works for example" $ test solver (exampleFile day) solutionExample
      it "works for input" $ test solver (inputFile day) solutionInput

    test :: Solver -> String -> String -> IO ()
    test solver file solution = do
      ex0in <- liftIO (solver <$> readLines file)
      ex0in `shouldBe` solution
