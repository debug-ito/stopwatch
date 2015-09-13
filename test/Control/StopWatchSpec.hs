module Control.StopWatchSpec (main, spec) where

import Control.Concurrent (threadDelay)

import Test.Hspec

import Control.StopWatch (stopWatch)
import System.Clock (TimeSpec, sec, nsec)

main :: IO ()
main = hspec spec

testStopWatch :: Int -> Int -> Expectation
testStopWatch threshold_range_msec target_msec = do
  (_, difftime) <- stopWatch $ threadDelay (target_msec * 1000)
  let got_diff_msec = fromIntegral $ (sec difftime) * 1000 + ((nsec difftime) `div` 1000000)
  got_diff_msec `shouldSatisfy` (>= target_msec - threshold_range_msec)
  got_diff_msec `shouldSatisfy` (<= target_msec + threshold_range_msec)

specStopWatch :: Int -> Int -> Spec
specStopWatch trange target = it ("should work for target " ++ (show target) ++ "msec and range " ++ (show trange) ++ "msec") $
  testStopWatch trange target

spec :: Spec
spec = do
  describe "stopWatch" $ do
    let trange = 30
    mapM_  (specStopWatch trange) [50, 100, 500, 1000]
