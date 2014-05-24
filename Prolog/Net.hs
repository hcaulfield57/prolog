module Prolog.Net (downloadProlog) where

import Network.HTTP
import System.IO

import Prolog.Error

prologURL :: String
prologURL = "http://98.131.104.126/prolog/"

downloadProlog :: (Int, Int) -> FilePath -> IO ()
downloadProlog now path = do
    let urlPath = getURLPath now
    result <- simpleHTTP $ getRequest urlPath
    case result of
        (Right _) -> do
            prolog <- getResponseBody result
            writeFile path prolog
        (Left e)  -> fatal (Just (show e)) False

getURLPath :: (Int, Int) -> String
getURLPath (month,day) = 
    let urlMonth = case month of
         1  -> "January"
         2  -> "February"
         3  -> "March"
         4  -> "April"
         5  -> "May"
         6  -> "June"
         7  -> "July"
         8  -> "August"
         9  -> "September"
         10 -> "October"
         11 -> "November"
         12 -> "December"
    in prologURL ++ urlMonth ++ show day ++ ".htm"
