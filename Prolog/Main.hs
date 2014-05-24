module Main (main) where

import System.Environment
import System.Exit

import Prolog.Console
import Prolog.Gui
import Prolog.Error

main :: IO ()
main = do
    argv <- getArgs
    case length argv of
        0 -> undefined -- gui/current date
        1 -> case head argv == "-d" of
            True  -> consoleLoop Nothing
            False -> guiLoop (Just (head argv))
        2 -> undefined -- console custom date
        _ -> fatal Nothing True
