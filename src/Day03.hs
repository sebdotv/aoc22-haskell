module Day03
  ( solveP1,
    solveP2,
  )
where

import Common (Solver)
import Data.Char (isAsciiLower, isAsciiUpper, ord)
import Data.List (intersect, nub)
import Data.List.Split (chunksOf)
import Text.Printf (printf)

singleElement :: [Char] -> Char
singleElement [x] = x
singleElement unexpected = error (printf "unexpected list: %s" unexpected)

sharedItem :: String -> Char
sharedItem = singleElement . nub . uncurry intersect . splitHalf
  where
    splitHalf ls = splitAt (length ls `div` 2) ls

priority :: Char -> Int
priority c = case c of
  x | isAsciiLower x -> ord x - ord 'a' + 1
  x | isAsciiUpper x -> ord x - ord 'A' + 27
  _ -> error "unexpected item"

solveP1 :: Solver
solveP1 = show . sum . map (priority . sharedItem)

intersection :: (Eq a) => [[a]] -> [a]
intersection = foldr1 intersect

solveP2 :: Solver
solveP2 = show . sum . map (priority . singleElement . nub . intersection) . chunksOf 3
