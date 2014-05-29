module Prolog.FilePath
    ( createDir
    , getPath
    , printProlog
    ) where

import System.Directory
import System.FilePath
import System.IO

import Prolog.Parse

getPath :: (Int, Int) -> IO FilePath
getPath (month,day) = do
    tmpDir <- getTemporaryDirectory
    return $ tmpDir </> "prolog" 
        </> show month </> show day <.> ".html"

createDir :: FilePath -> IO ()
createDir path = do
    let dir = takeDirectory path
    createDirectoryIfMissing True dir

printProlog :: FilePath -> IO String
printProlog path = do
    prolog <- readFile path
    return (parseHTML prolog)
