module Day05
  ( solveP1,
    solveP2,
  )
where

import Common (Solver)
import Data.List.Split (splitOn)
import Data.Maybe (fromMaybe)

type Stack = [Char]

-- | (from, to, n)
type Operation = (Int, Int, Int)

-- | (stacks, operations)
type State = ([Stack], [Operation])

parseStacks :: [String] -> [Stack]
parseStacks ls = [dropEmpty [fromMaybe ' ' (nth l (h * 4 + 1)) | l <- init ls] | h <- [0 .. nStacks -1]]
  where
    dropEmpty = dropWhile (== ' ')
    nth l i = if i < length l then Just (l !! i) else Nothing
    nStacks = read (last (words (last ls))) :: Int

parseOp :: String -> Operation
parseOp s = case words s of
  ["move", n, "from", from, "to", to] -> (read from - 1, read to - 1, read n)
  _ -> error "unexpected operation"

parseInput :: [String] -> State
parseInput ls = case splitOn [""] ls of
  [a, b] -> (parseStacks a, map parseOp b)
  _ -> error "unexpected input"

replace :: Int -> a -> [a] -> [a]
replace i x xs = prefix ++ x : suffix
  where
    suffix = case rest of
      _ : a -> a
      [] -> error "out of bounds"
    (prefix, rest) = splitAt i xs

type Mover = Operation -> [Stack] -> [Stack]

run :: Mover -> State -> [Stack]
run _ (stacks, []) = stacks
run mover (stacks, op : ops) = run mover (mover op stacks, ops)

solve :: Mover -> [String] -> String
solve mover ls = map head finalStacks
  where
    finalStacks = run mover input
    input = parseInput ls

solveP1 :: Solver
solveP1 = solve crateMover9000
  where
    crateMover9000 :: Mover
    crateMover9000 = apply
      where
        apply (_, _, 0) ss = ss
        apply (from, to, n) ss = apply (from, to, n - 1) (move1 ss from to)
        move1 ss from to = replace from stackFrom (replace to stackTo ss)
          where
            (value, stackFrom) = case ss !! from of
              a : b -> (a, b)
              _ -> error "cannot pop from empty list"
            stackTo = value : ss !! to

solveP2 :: Solver
solveP2 = solve crateMover9001
  where
    crateMover9001 :: Mover
    crateMover9001 (from, to, n) ss = replace from stackFrom (replace to stackTo ss)
      where
        (values, stackFrom) = splitAt n (ss !! from)
        stackTo = values ++ ss !! to
