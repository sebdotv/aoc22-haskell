# Advent of code 2022 solutions in Haskell

<img alt="Benchmark" height="75%" src="bench.svg" width="75%"/>

## Indent

Prerequisite:

```shell
stack install ormolu
```

### Fix all files inplace

```shell
ormolu --mode inplace $(git ls-files '*.hs')
```

## Test

### Run all tests

```shell
stack test
```

### Run specific tests

Run a single day

```shell
stack test --test-arguments '--match "day 05"'
```

Run a single test

```shell
stack test --test-arguments '--match "/day 05 P1/works for example/"'
```

## Benchmark

### Run all benchmarks

```shell
stack bench :aoc22-haskell-bench
```

### Store baseline

```shell
stack bench :aoc22-haskell-bench --benchmark-arguments '--csv bench.csv --svg bench.svg'
```

Visualize benchmark

```shell
chromium bench.svg
```

### Compare to baseline

```shell
stack bench :aoc22-haskell-bench --benchmark-arguments '--baseline bench.csv'
```

Compare a single instance

```shell
stack bench :aoc22-haskell-bench --benchmark-arguments '--baseline bench.csv --pattern "day 06 P2"'
```

## Profile

Prerequisite:

```shell
stack install ghc-prof-flamegraph
```

### Profile a specific solution

- Edit `prof/Prof.hs`
- Add Cost Centers manually: `{-# SCC id #-} <expression>`

```shell
stack bench :aoc22-haskell-prof --profile
```

```shell
cat aoc22-haskell-prof.prof | ghc-prof-flamegraph > aoc22-haskell-prof.svg && chromium aoc22-haskell-prof.svg
```

## Website interaction

### Download input

For today

```shell
aocdl -output 'data/{{printf "%02d" .Day}}-input.txt'
```

For a specific day

```shell
aocdl -output 'data/{{printf "%02d" .Day}}-input.txt' -day 3
```

### Submit solution

For today, part 1

```shell
aoc submit 1 7875
```

For a specific day, part 2

```shell
aoc submit 2 7875 --day 3
```
