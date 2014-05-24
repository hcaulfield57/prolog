module Prolog.Error (fatal) where

import System.Exit
import System.IO

fatal :: Maybe String -> Bool -> IO ()
fatal Nothing True = hPutStrLn stderr "usage: prolog [-d] [MM/DD]"
    >> exitWith (ExitFailure 1)
fatal (Just eMsg) True = hPutStrLn stderr eMsg
    >> putStrLn "usage: prolog [-d] [MM/DD]"
    >> exitWith (ExitFailure 1)
fatal (Just eMsg) False = hPutStrLn stderr eMsg
    >> exitWith (ExitFailure 1)
fatal Nothing False = error "This should never be called"
