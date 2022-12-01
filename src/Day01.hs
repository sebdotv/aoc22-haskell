module Day01
  ( solveP1,
    solveP2,
  )
where

import Control.Arrow
import Data.List (sortBy)
import Data.List.Split (splitOn)

sumGroup :: [String] -> Int
sumGroup = sum . map read

solveP1 :: [String] -> Int
solveP1 = splitOn [""] >>> map sumGroup >>> maximum

solveP2 :: [String] -> Int
solveP2 = splitOn [""] >>> map sumGroup >>> sum . take 3 . sortBy (flip compare)
