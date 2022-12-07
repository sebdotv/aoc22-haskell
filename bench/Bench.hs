import Common (dayStr, inputFile, readLines)
import Control.DeepSeq (force)
import Control.Exception (evaluate)
import Ref
import System.IO.Unsafe (unsafePerformIO)
import Test.Tasty.Bench
import Text.Printf (printf)

main :: IO ()
main =
  defaultMain
    [benchmarkDay (dayStr $ i + 1) (solver1, solver2) | (i, (solver1, solver2)) <- zip [0 ..] Ref.solvers]
  where
    benchmarkDay day (solver1, solver2) =
      env (evaluate (force (unsafePerformIO $ (readLines . inputFile) day))) $ \input ->
        bgroup
          (printf "day %s" day)
          [ bench (printf "day %s P1" day) $ nf solver1 input,
            bench (printf "day %s P2" day) $ nf solver2 input
          ]
