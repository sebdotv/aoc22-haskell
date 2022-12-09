module Day08
  ( solveP1,
    solveP2,
  )
where

import Common (Solver)
import Data.Char (ord)
import Data.List (transpose)

visible :: [Int] -> [Bool]
visible line = zipWith (>) line $ scanl max minBound line

solveP1 :: Solver
solveP1 input = show $ length $ filter (== True) $ concat anyDir
  where
    parseLine = map $ \x -> ord x - ord '0'
    parseInput = map parseLine
    trees = parseInput input
    leftOrRight f list = [zipWith (||) (reverse $ f (reverse line)) (f line) | line <- list]
    rows = leftOrRight visible trees
    tcols = transpose $ leftOrRight visible $ transpose trees
    anyDir = [zipWith (||) row tcol | (row, tcol) <- zip rows tcols]

solveP2 :: Solver
solveP2 = undefined
