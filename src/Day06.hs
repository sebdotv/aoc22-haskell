module Day06
  ( solveP1,
    solveP2,
  )
where

import Common (Solver)
import Data.Map (Map)
import qualified Data.Map as Map

detectStartOfPacket :: Int -> String -> Int
detectStartOfPacket len s = it s ([], Map.empty) 0
  where
    it :: String -> ([Char], Map Char Int) -> Int -> Int
    it [] _ _ = error "not found"
    it (x : xs) (buf, counts) pos =
      if Map.size counts == len
        then pos
        else it xs (kept, updatedCounts) (pos + 1)
      where
        (kept, out) = splitAt len (x : buf)
        incCount k = Map.insertWith (+) k 1
        decCount k = Map.update f k where f 1 = Nothing; f v = Just $ v - 1
        countsAfterInc = incCount x counts
        updatedCounts = case out of
          [] -> countsAfterInc
          [removed] -> decCount removed countsAfterInc
          _ -> error "unexpected value"

solveP1 :: Solver
solveP1 = show . map (detectStartOfPacket 4)

solveP2 :: Solver
solveP2 = show . map (detectStartOfPacket 14)
