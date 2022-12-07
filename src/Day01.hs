module Day01
  ( solveP1,
    solveP2,
  )
where

import Common (Solver)
import Data.List (sortBy)
import Data.List.Split (splitOn)

sumGroup :: [String] -> Int
sumGroup = sum . map read

solveP1 :: Solver
solveP1 = show . maximum . map sumGroup . splitOn [""]

solveP2 :: Solver
solveP2 = show . sum . take 3 . sortBy (flip compare) . map sumGroup . splitOn [""]
