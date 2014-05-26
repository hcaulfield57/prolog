import Graphics.UI.Gtk

main :: IO ()
main = do
    initGUI
    -- widgets
    window     <- windowNew
    todayB     <- buttonNewWithLabel "Today"
    yesterdayB <- buttonNewWithLabel "Yesterday"
    tomorrowB  <- buttonNewWithLabel "Tomorrow"
    windowBox  <- vBoxNew True 2
    menuBox    <- hBoxNew True 2
    textBuf    <- textBufferNew Nothing
    textView   <- textViewNewWithBuffer textBuf
    scroll     <- scrolledWindowNew Nothing Nothing
    menuBar    <- menuBarNew

    -- grab text
    text <- readFile "/tmp/prolog/5/12.html"
    textBufferSetText textBuf text

    -- configure widgets
    boxPackStart menuBox todayB PackNatural 0
    boxPackStart windowBox menuBox PackNatural 0
    boxPackStart windowBox textView PackGrow 0
    set window 
        [ windowTitle := "Prolog From Ochrid"
        , windowDefaultHeight := 400
        , windowDefaultWidth := 300 
        , containerChild := windowBox ]

    -- events
    onDestroy window mainQuit

    -- run it
    widgetShowAll window
    mainGUI
