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

type StrategyLine = (Shape, Shape)

data Outcome = Win | Loss | Draw deriving (Enum, Eq)

parseOpponentShape :: Char -> Shape
parseOpponentShape 'A' = Rock
parseOpponentShape 'B' = Paper
parseOpponentShape 'C' = Scissors
parseOpponentShape _ = error "unsupported shape"

parseLine :: String -> StrategyLine
parseLine [a, ' ', b] = (parseOpponentShape a, parseMeShape b)
  where
    parseMeShape 'X' = Rock
    parseMeShape 'Y' = Paper
    parseMeShape 'Z' = Scissors
    parseMeShape _ = error "unsupported shape"
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
evalStrategyLine (opponent, me) = shapeScore me + outcomeScore (outcome opponent me)

solveP1 :: Solver
solveP1 = map parseLine >>> map evalStrategyLine >>> sum

--

parseOutcome :: Char -> Outcome
parseOutcome 'X' = Loss
parseOutcome 'Y' = Draw
parseOutcome 'Z' = Win
parseOutcome _ = error "unsupported outcome"

type StrategyLineP2 = (Shape, Outcome)

--data StrategyLineP2 = StrategyLineP2 {opponentP2 :: Shape, outcomeP2 :: Outcome}

parseLineP2 :: String -> StrategyLineP2
parseLineP2 [a, ' ', b] = (parseOpponentShape a, parseOutcome b)
parseLineP2 _ = error "unsupported line"

shapes :: [Shape]
shapes = [minBound .. maxBound]

findAction :: StrategyLineP2 -> Maybe Shape
findAction (a, b) = find (\x -> outcome a x == b) shapes

convertToStrategyLine :: StrategyLineP2 -> StrategyLine
convertToStrategyLine (a, b) = (a, fromJust (findAction (a, b)))

solveP2 :: Solver
solveP2 = map parseLineP2 >>> map convertToStrategyLine >>> map evalStrategyLine >>> sum
