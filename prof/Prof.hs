import Common
import Day06

main :: IO ()
main = do
  lines <- readLines $ inputFile "06"
  putStrLn $ Day06.solveP2 lines
