# stopwatch

A simple stopwatch utility for Haskell.

## How to run tests

```
cabal configure --enable-tests && cabal build && cabal test
```

## Important test flag

- `test_delay_upper_bound`: Default: False. If True, the test checks
  the return value of `stopWatch` with upper bounds. If False, it
  doesn't check upper bounds. It checks lower bounds only.



## Author

Toshio Ito <debug.ito@gmail.com>
