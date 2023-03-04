require("ncurses.sluacurses")


local NcursesIo <const> = {}
NcursesIo.__index = NcursesIo

local getch    <const> = getch
local mvprintw <const> = mvprintw
local refresh  <const> = refresh
local clear    <const> = clear
local KEY_MOUSE  <const> = KEY_MOUSE
local attron <const> = attron
local attroff <const> = attroff
local A_BOLD <const> = A_BOLD
local color_pair <const> = COLOR_PAIR
local button1Clicked <const> = BUTTON1_CLICKED
local button1DoubleClick <const> = BUTTON1_DOUBLE_CLICKED

NcursesIo.keyMouse = KEY_MOUSE
NcursesIo.button1Clicked = button1Clicked
NcursesIo.button1DoubleClick = button1DoubleClick

_ENV = NcursesIo

function NcursesIo:attrOn(attr)
   attron(color_pair(attr))
end

function NcursesIo:attrOff(attr)
    attroff(color_pair(attr))
end

function NcursesIo:mvprintw(y,x,char)
   mvprintw(y,x,"%s",char)
end

function NcursesIo:getCh()
    return getch()    
end

function NcursesIo:refresh()
    refresh()
end

function NcursesIo:clearScreen()
    clear()
end

function NcursesIo:boldOn()
   attron(A_BOLD)
end

function NcursesIo:boldOff()
    attroff(A_BOLD)
end



return NcursesIo

