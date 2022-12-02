module Day02
  ( solveP1,
    solveP2,
  )
where

import Common (Solver)
import Control.Arrow

data Shape = Rock | Paper | Scissors deriving (Enum, Eq)

data StrategyLine = StrategyLine {opponent :: Shape, me :: Shape}

data Outcome = Win | Loss | Draw deriving (Enum)

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

solveP2 :: Solver
solveP2 = undefined
