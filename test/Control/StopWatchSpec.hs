{-# LANGUAGE CPP #-}
module Control.StopWatchSpec (main, spec) where

import Control.Concurrent (threadDelay)

import Test.Hspec

import Control.StopWatch (stopWatch)
import System.Clock (sec, nsec)

main :: IO ()
main = hspec spec

checker :: Int -> Int -> (String, Int -> Expectation)
checker threshold_range_msec target_msec = (description, checker_func) where
#ifdef TEST_DELAY_UPPER_BOUND
  description = "target " ++ (show target_msec) ++ "msec and range +- " ++ (show threshold_range_msec) ++ "msec"
  checker_func got_diff_msec = do
    got_diff_msec `shouldSatisfy` (>= target_msec - threshold_range_msec)
    got_diff_msec `shouldSatisfy` (<= target_msec + threshold_range_msec)
#else
  description = "target " ++ (show target_msec) ++ "msec and lower bound -" ++ (show threshold_range_msec) ++ "msec"
  checker_func got_diff_msec = do
    got_diff_msec `shouldSatisfy` (>= target_msec - threshold_range_msec)
#endif

specStopWatch :: Int -> Int -> Spec
specStopWatch threshold_range_msec target_msec =
  it ("should work for " ++ description) $ do
    (_, difftime) <- stopWatch $ threadDelay (target_msec * 1000)
    let got_diff_msec = fromIntegral $ (sec difftime) * 1000 + ((nsec difftime) `div` 1000000)
    checkerFunc got_diff_msec
  where
    (description, checkerFunc) = checker threshold_range_msec target_msec
    

spec :: Spec
spec = do
  describe "stopWatch" $ do
    let trange = 30
    mapM_  (specStopWatch trange) [50, 100, 500, 1000]
