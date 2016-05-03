{-# LANGUAGE CPP #-}
module Control.StopWatchSpec (main, spec) where

import Control.Concurrent (threadDelay)

import Test.Hspec

import Control.StopWatch (stopWatch)
import System.Clock (TimeSpec(sec, nsec))

main :: IO ()
main = hspec spec

checker :: Int -> Int -> (String, TimeSpec -> Bool)
checker threshold_range_msec target_msec = (description, checker_func) where
  ts2msec ts = fromIntegral $ (sec ts) * 1000 + ((nsec ts) `div` 1000000)
#ifdef TEST_DELAY_UPPER_BOUND
  description = "target " ++ (show target_msec) ++ "msec and range +- " ++ (show threshold_range_msec) ++ "msec"
  checker_func got = (ts2msec got >= target_msec - threshold_range_msec)
                     && (ts2msec got <= target_msec + threshold_range_msec)
#else
  description = "target " ++ (show target_msec) ++ "msec and lower bound -" ++ (show threshold_range_msec) ++ "msec"
  checker_func got = (ts2msec got >= target_msec - threshold_range_msec)
#endif

specStopWatch :: Int -> Int -> Spec
specStopWatch threshold_range_msec target_msec =
  it ("should work for " ++ description) $ do
    (_, difftime) <- stopWatch $ threadDelay (target_msec * 1000)
    difftime `shouldSatisfy` checkerFunc
  where
    (description, checkerFunc) = checker threshold_range_msec target_msec
    

spec :: Spec
spec = do
  describe "stopWatch" $ do
    let trange = 30
    mapM_  (specStopWatch trange) [50, 100, 500, 1000]
