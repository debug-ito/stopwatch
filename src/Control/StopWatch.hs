-- |
-- Module: Control.StopWatch
-- Description: A simple stopwatch utility
-- Maintainer: Toshio Ito <debug.ito@gmail.com>
--
-- A simple stopwatch utility function(s).
--
module Control.StopWatch (
  stopWatch
) where

import Control.Monad.IO.Class (MonadIO, liftIO)
import System.Clock (TimeSpec, getTime, Clock(Monotonic), diffTimeSpec)

-- | Execute the given computation, measure the time it takes and
-- return the result.
stopWatch :: MonadIO m => m a -> m (a, TimeSpec)
stopWatch act = do
  start <- liftIO $ getTime Monotonic
  ret <- act
  end <- liftIO $ getTime Monotonic
  return (ret, end `diffTimeSpec` start)
