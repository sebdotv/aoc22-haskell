#      

## Running tests

### Run specific tests

Run a single day

```shell
stack test --test-arguments '--match "day 05"'
```

Run a single test

```shell
stack test --test-arguments '--match "/day 05 P1/works for example/"'
```

## Interacting with website

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
