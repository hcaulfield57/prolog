module Prolog.Console (consoleLoop) where

import System.Directory
import System.Exit

import Prolog.Error
import Prolog.FilePath
import Prolog.Net
import Prolog.Parse
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
consoleLoop (Just date) = do
    case parseDate date of
        (Just target) -> do
            path   <- getPath target
            exists <- doesFileExist path
            createDir path
            case exists of
                True  -> printProlog path
                False -> do
                    downloadProlog target path
                    printProlog path
        Nothing       -> fatal
            (Just "malformed date") True
