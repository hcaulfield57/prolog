module Prolog.Time (today) where

import Data.Time
import Data.Time.Calendar.Julian
import Data.Time.Calendar.MonthDay

today :: IO (Int, Int)
today = do
    now <- getCurrentTime
    let day           = utctDay now
        (year,dayInt) = toJulianYearAndDay day
        isLeapYear    = isJulianLeapYear year
    return $ dayOfYearToMonthAndDay isLeapYear dayInt
