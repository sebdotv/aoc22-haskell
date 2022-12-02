module Day02
  ( solveP1,
    solveP2,
  )
where

import Common (Solver)
import Control.Arrow
import Data.List
import Data.Maybe

data Shape = Rock | Paper | Scissors deriving (Enum, Eq, Show, Bounded)

data StrategyLine = StrategyLine {opponent :: Shape, me :: Shape}

data Outcome = Win | Loss | Draw deriving (Enum, Eq)

parseOpponentShape 'A' = Rock
parseOpponentShape 'B' = Paper
parseOpponentShape 'C' = Scissors

parseMeShape 'X' = Rock
parseMeShape 'Y' = Paper
parseMeShape 'Z' = Scissors

parseLine [opponent, ' ', me] = StrategyLine (parseOpponentShape opponent) (parseMeShape me)

outcome Rock Scissors = Loss
outcome Scissors Paper = Loss
outcome Paper Rock = Loss
outcome a b
  | a == b = Draw
  | otherwise = Win

shapeScore Rock = 1
shapeScore Paper = 2
shapeScore Scissors = 3

outcomeScore Loss = 0
outcomeScore Draw = 3
outcomeScore Win = 6

evalStrategyLine l = shapeScore (me l) + outcomeScore (outcome (opponent l) (me l))

solveP1 :: Solver
solveP1 = map parseLine >>> map evalStrategyLine >>> sum

--

parseOutcome 'X' = Loss
parseOutcome 'Y' = Draw
parseOutcome 'Z' = Win

data StrategyLineP2 = StrategyLineP2 {opponentP2 :: Shape, outcomeP2 :: Outcome}

parseLineP2 [opponent, ' ', outcome] = StrategyLineP2 (parseOpponentShape opponent) (parseOutcome outcome)

shapes :: [Shape]
shapes = [minBound .. maxBound]

findAction :: StrategyLineP2 -> Maybe Shape
findAction l = find (\x -> outcome (opponentP2 l) x == outcomeP2 l) shapes

findAction2 :: StrategyLineP2 -> Shape
findAction2 l = fromJust (findAction l)

convertToStrategyLine :: StrategyLineP2 -> StrategyLine
convertToStrategyLine l = StrategyLine (opponentP2 l) (findAction2 l)

solveP2 :: Solver
solveP2 = map parseLineP2 >>> map convertToStrategyLine >>> map evalStrategyLine >>> sum
