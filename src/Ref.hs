module Ref (solvers) where

import Common (Solver)
import Day01
import Day02
import Day03
import Day04
import Day05
import Day06
import Day07
import Day08

solvers :: [(Solver, Solver)]
solvers =
  [ (Day01.solveP1, Day01.solveP2),
    (Day02.solveP1, Day02.solveP2),
    (Day03.solveP1, Day03.solveP2),
    (Day04.solveP1, Day04.solveP2),
    (Day05.solveP1, Day05.solveP2),
    (Day06.solveP1, Day06.solveP2),
    (Day07.solveP1, Day07.solveP2),
    (Day08.solveP1, Day08.solveP2)
  ]
