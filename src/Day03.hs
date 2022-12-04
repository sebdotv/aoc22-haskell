module Day03
  ( solveP1,
    solveP2,
  )
where

import Common (Solver)
import Data.Char (ord)
import Data.List (intersect, nub)
import Text.Printf (printf)

sharedItem :: String -> Char
sharedItem = singleElement . nub . uncurry intersect . splitHalf
  where
    splitHalf ls = splitAt (length ls `div` 2) ls

    singleElement [x] = x
    singleElement unexpected = error (printf "unexpected list: %s" unexpected)

solveP1 :: Solver
solveP1 = sum . map (score . sharedItem)
  where
    score c = case c of
      x | x >= 'a' && x <= 'z' -> ord x - ord 'a' + 1
      x | x >= 'A' && x <= 'Z' -> ord x - ord 'A' + 27
      _ -> error "unexpected item"

solveP2 :: Solver
solveP2 = undefined
