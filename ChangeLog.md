# Revision history for stopwatch

## 0.1.0.3 -- 2016-10-09

* Confirmed build with `hspec-2.3.0`.


## 0.1.0.2 -- 2016-05-22

* Dependency version range for `base` was too wide.


## 0.1.0.1 -- 2016-05-03

* Expand dependency version ranges for `transformers` and `clock`.

* Loosen the test. Now it checks only lower bounds of the measured
  delay, not upper bounds. This is because in some environments, it's
  difficult to ensure the upper bounds.


## 0.1.0  -- 2015-09-13

* First version. Released on an unsuspecting world.
