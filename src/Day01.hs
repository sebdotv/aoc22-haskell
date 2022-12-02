module Day01
  ( solveP1,
    solveP2,
  )
where

import Common (Solver)
import Control.Arrow
import Data.List (sortBy)
import Data.List.Split (splitOn)

sumGroup :: [String] -> Int
sumGroup = sum . map read

solveP1 :: Solver
solveP1 = splitOn [""] >>> map sumGroup >>> maximum

solveP2 :: Solver
solveP2 = splitOn [""] >>> map sumGroup >>> sum . take 3 . sortBy (flip compare)
