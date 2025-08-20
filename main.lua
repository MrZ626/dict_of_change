require "Zenitha"

FONT.load("def", "unifont-15.1.02.otf")
FONT.setDefaultFont("def")

SCR.setSize(1600, 900)
ZENITHA.setShowFPS(false)

ZENITHA.globalEvent.drawCursor = NULL
ZENITHA.globalEvent.clickFX = NULL

SCN.add("index", require "reader")
ZENITHA.setFirstScene("index")
