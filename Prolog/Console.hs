module Prolog.Console (consoleLoop) where

import System.Directory
import System.Exit

import Prolog.FilePath
import Prolog.Net
import Prolog.Time

consoleLoop :: Maybe String -> IO ()
consoleLoop Nothing = do
    now    <- today
    path   <- getPath now
    exists <- doesFileExist path
    createDir path
    case exists of
        True  -> printProlog path
        False -> do
            downloadProlog now path
            printProlog path
