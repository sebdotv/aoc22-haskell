module Day07
  ( solveP1,
    solveP2,
  )
where

import Common (Solver)
import Data.List (isPrefixOf)
import Data.List.Split (dropInitBlank, keepDelimsL, split, whenElt)
import Data.Map (Map, (!))
import qualified Data.Map as Map

newtype Directory = Directory [String] deriving (Eq, Show, Ord)

data ListingItem = DirItem String | FileItem Int String deriving (Eq, Show)

data Command = Cd String | Ls [ListingItem] deriving (Eq, Show)

parseCommands :: [String] -> [Command]
parseCommands = map parseCommand . extractLineGroups
  where
    extractLineGroups = split (dropInitBlank $ keepDelimsL $ whenElt (isPrefixOf "$"))

    parseCommand :: [String] -> Command
    parseCommand (x : xs) = case (words x, xs) of
      (["$", "ls"], rest) -> Ls (map parseListingItem rest)
      (["$", "cd", a], []) -> Cd a
      _ -> error "unrecognized group"
    parseCommand [] = error "empty group"

    parseListingItem :: String -> ListingItem
    parseListingItem x = case words x of
      ["dir", s] -> DirItem s
      [sizeS, s] -> FileItem (read sizeS) s
      _ -> error "unrecognized listing item"

data InterpreterState = InterpreterState {isCurrDir :: Directory, isListings :: Map Directory [ListingItem]} deriving (Eq, Show)

interpretCommands :: [Command] -> Map Directory [ListingItem]
interpretCommands commands = isListings finalState
  where
    initialState = InterpreterState (Directory []) Map.empty
    finalState = foldl interpret initialState commands

    interpret :: InterpreterState -> Command -> InterpreterState
    interpret s@(InterpreterState (Directory d) l) cmd = case cmd of
      Cd arg -> s {isCurrDir = Directory subDir}
        where
          subDir = case arg of
            "/" -> []
            ".." -> tail d
            other -> other : d
      Ls items -> s {isListings = updatedListings}
        where
          updatedListings = Map.insertWith checkNew (Directory d) items l

computeTotalSizes :: Map Directory [ListingItem] -> Map Directory Int
computeTotalSizes listings = snd $ walk (Directory [])
  where
    walk :: Directory -> (Int, Map Directory Int)
    walk dir@(Directory d) = (totalSize, Map.insertWith checkNew dir totalSize (Map.unionsWith checkNew (map snd items)))
      where
        totalSize = sum (map fst items)
        items :: [(Int, Map Directory Int)]
        items = [process item | item <- listings ! dir]
        process :: ListingItem -> (Int, Map Directory Int)
        process (FileItem s _) = (s, Map.empty)
        process (DirItem n) = walk (Directory (n : d))

totalSizes :: [String] -> Map Directory Int
totalSizes = computeTotalSizes . interpretCommands . parseCommands

solveP1 :: Solver
solveP1 = show . sum . filter (<= 100000) . map snd . Map.toList . totalSizes

solveP2 :: Solver
solveP2 input = (show . minimum . filter (>= required) . map snd . Map.toList) ts
  where
    ts = totalSizes input
    unused = 70000000 - (ts ! Directory [])
    required = 30000000 - unused

-- paranoia
checkNew :: a -> a -> a
checkNew _ _ = error "duplicate map entry"
