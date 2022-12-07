module Common
  ( Solver,
    mapTuple,
    dbg,
    dayStr,
    exampleFile,
    inputFile,
    readLines,
  )
where

import Debug.Trace (trace)
import Text.Printf (printf)

type Solver = [String] -> String

-- https://stackoverflow.com/a/9722949
mapTuple :: (a -> b) -> (a, a) -> (b, b)
mapTuple f (a1, a2) = (f a1, f a2)

-- | Wrapper for trace
--
-- __Examples:__
--
-- @
--    . dbg "commands"
--    . map parseCommand
--    . dbg "lineGroups"
--    . lineGroups
-- @
--
-- @
--    dbg "updated State" $ case cmd of [...]
-- @
dbg :: Show a => String -> a -> a
dbg label x = trace ("\n>>> " ++ label ++ ": " ++ show x) x

dayStr :: Int -> String
dayStr = printf "%02d"

exampleFile :: String -> String
exampleFile = printf "./data/%s-example.txt"

inputFile :: String -> String
inputFile = printf "./data/%s-input.txt"

readLines :: FilePath -> IO [String]
readLines name = lines <$> readFile name
