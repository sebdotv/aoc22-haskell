# Advent of code 2022 solutions in Haskell

<img alt="Benchmark" height="75%" src="bench.svg" width="75%"/>

## Test

### Run all tests

```shell
stack test :aoc22-haskell-test
```

### Run specific tests

Run a single day

```shell
stack test :aoc22-haskell-test --test-arguments '--match "day 05"'
```

Run a single test

```shell
stack test :aoc22-haskell-test --test-arguments '--match "/day 05 P1/works for example/"'
```


## Benchmark

### Run all benchmarks

```shell
stack test :aoc22-haskell-bench
```

### Visualize benchmark results

```shell
stack test :aoc22-haskell-bench --test-arguments "--svg bench.svg --color always" && chromium bench.svg
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
