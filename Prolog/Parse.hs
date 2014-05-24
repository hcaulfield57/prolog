module Prolog.Parse (parseDate, parseHTML) where

import Data.List
import Text.HTML.TagSoup

parseDate :: String -> Maybe (Int, Int)
parseDate date
    | length date == 5 =
        let (m,d) = break (== '/') date
            d'    = filter (`notElem` "/") d
            month = read m
            day   = read d'
        in (Just (month,day))
    | otherwise = Nothing

parseHTML :: String -> String
parseHTML html = innerText $ parseTags html
