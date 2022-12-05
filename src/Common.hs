module Common
  ( Solver,
    SolverS,
    GenericSolver,
    mapTuple,
  )
where

type GenericSolver a = [String] -> a

type Solver = GenericSolver Int

type SolverS = GenericSolver String

-- https://stackoverflow.com/a/9722949
mapTuple :: (a -> b) -> (a, a) -> (b, b)
mapTuple f (a1, a2) = (f a1, f a2)
