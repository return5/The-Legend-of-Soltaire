local NcurseAux <const> = require('ncurses.NcursesAux')
local NcurseIo <const> = require('ncurses.NcursesIO')

local Output <const> = {}
Output.__index = Output
_ENV = Output


function Output:refresh()
	NcurseIo:refresh()
end

function Output:clearScr()
	NcurseIo:clearScreen()
end

function Output:attron(color)
	NcurseIo:attrOn(color)
end

function Output:attroff(color)
	NcurseIo:attrOff(color)
end

function Output:getColor(suite)
	return NcurseAux.colors[suite]
end

function Output:printLine(x,y,line)
	NcurseIo:mvprintw(y,x,line)
end

function Output:boldOn()
	NcurseIo:boldOn()
end

function Output:boldOff()
	NcurseIo:boldOff()
end

function Output:printCards(stacks,cards)
	self:clearScr()
	for i=1,#stacks,1 do
		stacks[i]:print()
	end
	stacks.draw:print()
	stacks.grab:print()
	for i=1,#cards,1 do
		cards[i]:printBold()
	end
	self:refresh()
end

function Output:printEndGame()
	self:clearScr()
	self:printLine(10,3,"Game over. Would you like to continue(y/n)?")
	self:refresh()
end

return Output
