module Day02
  ( solveP1,
    solveP2,
  )
where

import Common (Solver)
import Control.Arrow
import Data.List (find)
import Data.Maybe (fromJust)

data Shape = Rock | Paper | Scissors deriving (Enum, Eq, Show, Bounded)

data StrategyLine = StrategyLine {opponent :: Shape, me :: Shape}

data Outcome = Win | Loss | Draw deriving (Enum, Eq)

parseOpponentShape :: Char -> Shape
parseOpponentShape 'A' = Rock
parseOpponentShape 'B' = Paper
parseOpponentShape 'C' = Scissors
parseOpponentShape _ = error "unsupported shape"

parseMeShape :: Char -> Shape
parseMeShape 'X' = Rock
parseMeShape 'Y' = Paper
parseMeShape 'Z' = Scissors
parseMeShape _ = error "unsupported shape"

parseLine :: String -> StrategyLine
parseLine [a, ' ', b] = StrategyLine (parseOpponentShape a) (parseMeShape b)
parseLine _ = error "unsupported line"

outcome :: Shape -> Shape -> Outcome
outcome Rock Scissors = Loss
outcome Scissors Paper = Loss
outcome Paper Rock = Loss
outcome a b
  | a == b = Draw
  | otherwise = Win

shapeScore :: Shape -> Int
shapeScore Rock = 1
shapeScore Paper = 2
shapeScore Scissors = 3

outcomeScore :: Outcome -> Int
outcomeScore Loss = 0
outcomeScore Draw = 3
outcomeScore Win = 6

evalStrategyLine :: StrategyLine -> Int
evalStrategyLine l = shapeScore (me l) + outcomeScore (outcome (opponent l) (me l))

solveP1 :: Solver
solveP1 = map parseLine >>> map evalStrategyLine >>> sum

--

parseOutcome :: Char -> Outcome
parseOutcome 'X' = Loss
parseOutcome 'Y' = Draw
parseOutcome 'Z' = Win
parseOutcome _ = error "unsupported outcome"

data StrategyLineP2 = StrategyLineP2 {opponentP2 :: Shape, outcomeP2 :: Outcome}

parseLineP2 :: String -> StrategyLineP2
parseLineP2 [a, ' ', b] = StrategyLineP2 (parseOpponentShape a) (parseOutcome b)
parseLineP2 _ = error "unsupported line"

shapes :: [Shape]
shapes = [minBound .. maxBound]

findAction :: StrategyLineP2 -> Maybe Shape
findAction l = find (\x -> outcome (opponentP2 l) x == outcomeP2 l) shapes

convertToStrategyLine :: StrategyLineP2 -> StrategyLine
convertToStrategyLine l = StrategyLine (opponentP2 l) (fromJust (findAction l))

solveP2 :: Solver
solveP2 = map parseLineP2 >>> map convertToStrategyLine >>> map evalStrategyLine >>> sum
