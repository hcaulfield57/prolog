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
        True  -> putStr =<< printProlog path
        False -> do
            downloadProlog now path
<<<<<<< HEAD
            putStr =<< printProlog path
consoleLoop (Just date) = do
=======
            printProlog path
consoleLoop (Just date) =
>>>>>>> a6f87a2081e53dc35ecb9573dcf9b5fa0e2ede76
    case parseDate date of
        (Just target) -> do
            path   <- getPath target
            exists <- doesFileExist path
            createDir path
            case exists of
                True  -> putStr =<< printProlog path
                False -> do
                    downloadProlog target path
                    putStr =<< printProlog path
        Nothing       -> fatal
            (Just "malformed date") True
