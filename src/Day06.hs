module Day06
  ( solveP1,
    solveP2,
  )
where

import Common (SolverIA)
import Data.List (group, sort)

detectStartOfPacket :: Int -> String -> Int
detectStartOfPacket len s = it s [] 0
  where
    it :: String -> [Char] -> Int -> Int
    it [] _ _ = error "not found"
    it (x : xs) buf pos =
      if length (group (sort buf)) == len
        then pos
        else it xs (take len (x : buf)) (pos + 1)

solveP1 :: SolverIA
solveP1 = map (detectStartOfPacket 4)

solveP2 :: SolverIA
solveP2 = map (detectStartOfPacket 14)
