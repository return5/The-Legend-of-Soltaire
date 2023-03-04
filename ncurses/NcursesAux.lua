local ncurses  <const> = require("ncurses.sluacurses")

local NcursesAux   <const> = {}
NcursesAux.__index = NcursesAux

local initscr   <const> = initscr
local cbreak    <const> = cbreak
local keypad    <const> = keypad
local mousemask <const> = mousemask
local refresh   <const> = refresh
local stdscr    <const> = stdscr
local endwin    <const> = endwin
local noecho    <const> = noecho
local curs_set  <const> = curs_set
local ALL_MOUSE_EVENTS <const> = ALL_MOUSE_EVENTS
local init_pair <const> = init_pair
local CYAN <const> = COLOR_CYAN
local BLACK <const> = COLOR_BLACK
local MAGENTA <const> = COLOR_MAGENTA
local start_color <const> = start_color

_ENV = NcursesAux


NcursesAux.colors = {
    RED = 1,
    BLUE = 2
}


local function initPair(i,fg,bg)
    init_pair(i,fg,bg)
end

local function initColors()
    initPair(NcursesAux.colors.RED,MAGENTA,BLACK)
    initPair(NcursesAux.colors.BLUE,CYAN,BLACK)
end


function NcursesAux:initNcurses()
    initscr()
    cbreak()  --disable line buffering
    noecho() --dont show user input on screen
    keypad(stdscr,1) --enable keypad. needed for mouse
    mousemask(ALL_MOUSE_EVENTS) --enable mouse input
    curs_set(0)  --dont show cursor
    start_color()
    initColors()
    refresh()
end

function NcursesAux:endNcurses()
    endwin()
end

return NcursesAux

