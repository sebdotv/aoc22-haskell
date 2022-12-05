module Day04
  ( solveP1,
    solveP2,
  )
where

import Common (Solver, mapTuple)
import Data.List.Split (splitOn)

type Line = ((Int, Int), (Int, Int))

parseLine :: String -> Line
parseLine = mapTuple bounds . pairs
  where
    bounds s = case splitOn "-" s of
      [a, b] -> (read a, read b)
      _ -> error "unexpected bounds"
    pairs s = case splitOn "," s of
      [a, b] -> (a, b)
      _ -> error "unexpected pair"

redundant :: Line -> Bool
redundant l = case l of
  (a, b) -> a `fullyContains` b || b `fullyContains` a
    where
      (x1, x2) `fullyContains` (y1, y2) = x1 <= y1 && y2 <= x2

overlapping :: Line -> Bool
overlapping l = case l of
  (a, b) -> a `overlaps` b || b `overlaps` a
    where
      (x1, x2) `overlaps` (y1, y2) = x1 <= y1 && y1 <= x2 || x1 <= y2 && y2 <= x2

count :: (a -> Bool) -> [a] -> Int
count p = length . filter p

solveP1 :: Solver
solveP1 = count redundant . map parseLine

solveP2 :: Solver
solveP2 = count overlapping . map parseLine
