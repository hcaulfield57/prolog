module Prolog.Parse (parseDate, parseHTML) where

import Data.List
import Text.HTML.TagSoup
import Text.PrettyPrint

parseDate :: String -> Maybe (Int, Int)
parseDate date
    | length date == 5 =
        let (m,d) = break (== '/') date
            d'    = filter (`notElem` "/") d
            month = read m
            day   = read d'
        in Just (month,day)
    | otherwise = Nothing

parseHTML :: String -> String
parseHTML html =
    let sty = Style PageMode 80 1.5
        par = renderStyle sty $ prettyHTML (parseTags html)
    in tabs . newline $ par
  -- some of the formatting that these files come in is
  -- pretty awful, this is an attempt to fix it however
  -- it doesn't help a ton, needs some work.
  where tabs (x:xs) = 
            if x == '\t'
            then ' ' : tabs xs
            else x : tabs xs
        tabs [] = []

        newline (x1:x2:xs) =
            if x1 == x2
            then x1 : newline xs
            else x1 : x2 : newline xs
        newline (x:[]) = [x]
        newline [] = []

prettyHTML :: [Tag String] -> Doc
prettyHTML [] = empty
prettyHTML (t:ts) = case t of
    (TagOpen tag _) -> case tag of
        "P" -> char '\n' <> prettyHTML ts
        "p" -> char '\n' <> prettyHTML ts
        _   -> prettyHTML ts
    (TagText txt) -> text txt <> prettyHTML ts
    _             -> prettyHTML ts
