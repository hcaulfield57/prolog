module Prolog.Gui (guiLoop) where

import Control.Monad (when)
import Graphics.UI.Gtk
import System.Directory

import Prolog.Error
import Prolog.FilePath
import Prolog.Net
import Prolog.Parse
import Prolog.Time

guiLoop :: Maybe String -> IO ()
guiLoop Nothing = do
    -- same as consoleLoop, get initial file
    now    <- today
    path   <- getPath now
    exists <- doesFileExist path
    createDir path
    when (not exists)
        (downloadProlog now path)
    prologGUI path
guiLoop (Just date) = do
    -- same as consoleLoop, get initial file
    case parseDate date of
        (Just target) -> do
            path   <- getPath target
            exists <- doesFileExist path
            createDir path
            when (not exists)
                (downloadProlog target path)
            prologGUI path
        Nothing       -> fatal
            (Just "malformed date") True

prologGUI :: FilePath -> IO ()
prologGUI path = do
    initGUI
    -- widgets
    rootW      <- windowNew
    todayB     <- buttonNewWithLabel "Today"
    yesterdayB <- buttonNewWithLabel "Yesterday"
    tomorrowB  <- buttonNewWithLabel "Tomorrow"
    rootBX     <- vBoxNew False 2
    menuBX     <- hBoxNew True 2
    bufTB      <- textBufferNew Nothing
    prologTV   <- textViewNewWithBuffer bufTB
    prologSW   <- scrolledWindowNew Nothing Nothing

    -- load initial file into buffer
    prolog <- printProlog path
    textBufferSetText bufTB prolog
    containerAdd prologSW prologTV

    -- configure widgets
    boxPackStart menuBX todayB PackNatural 0
    boxPackStart menuBX yesterdayB PackNatural 0
    boxPackStart menuBX tomorrowB PackNatural 0
    boxPackStart rootBX menuBX PackNatural 0
    boxPackStart rootBX prologSW PackGrow 0
    set rootW
        [ windowTitle := "Prolog From Ochrid"
        , windowDefaultHeight := 400
        , windowDefaultWidth := 300
        , containerChild := rootBX ]

    -- events
    onDestroy rootW mainQuit

    widgetShowAll rootW
    mainGUI
