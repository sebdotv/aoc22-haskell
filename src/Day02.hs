module Day02
  ( solveP1,
    solveP2,
  )
where

import Common (Solver)
import Data.List (find)
import Data.Maybe (fromJust)

data Shape = Rock | Paper | Scissors deriving (Enum, Eq, Show, Bounded)

shapes :: [Shape]
shapes = [minBound .. maxBound]

type StrategyLine = (Shape, Shape)

data Outcome = Win | Loss | Draw deriving (Enum, Eq)

parseOpponentShape :: Char -> Shape
parseOpponentShape 'A' = Rock
parseOpponentShape 'B' = Paper
parseOpponentShape 'C' = Scissors
parseOpponentShape _ = error "unsupported shape"

parseLineP1 :: String -> StrategyLine
parseLineP1 [a, ' ', b] = (parseOpponentShape a, parseMeShape b)
  where
    parseMeShape 'X' = Rock
    parseMeShape 'Y' = Paper
    parseMeShape 'Z' = Scissors
    parseMeShape _ = error "unsupported shape"
parseLineP1 _ = error "unsupported line"

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
solveP1 = sum . fmap (evalStrategyLine . parseLineP1)

--

type IntentLine = (Shape, Outcome)

parseLineP2 :: String -> IntentLine
parseLineP2 [a, ' ', b] = (parseOpponentShape a, parseOutcome b)
  where
    parseOutcome 'X' = Loss
    parseOutcome 'Y' = Draw
    parseOutcome 'Z' = Win
    parseOutcome _ = error "unsupported outcome"
parseLineP2 _ = error "unsupported line"

findAction :: IntentLine -> Maybe Shape
findAction (a, b) = find (\x -> outcome a x == b) shapes

convertToStrategyLine :: IntentLine -> StrategyLine
convertToStrategyLine (a, b) = (a, fromJust $ findAction (a, b))

solveP2 :: Solver
solveP2 = sum . fmap (evalStrategyLine . convertToStrategyLine . parseLineP2)
