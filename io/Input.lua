local NcurseIo <const> = require('ncurses.NcursesIO')

local Input <const> = {}
Input.__index = Input

_ENV = Input

function Input:getUserInput()
	return NcurseIo:getCh()
end

local function doubleClick(cards,clickable,stacks)
	local start <const> = #cards > 1 and 5 or 1
	for i=start,#stacks,1 do
		if stacks[i] ~= cards[1].stack and stacks[i]:checkIfCanAdd(cards[1]) then
			return stacks[i].cards[#stacks[i].cards]:clickMe(cards,clickable,stacks)
		end
	end
	return true,{}
end

function Input:getInput(current,clickable,stacks)
	local ch,x,y,bstate = self:getUserInput()
	if ch == "MOUSE_CLICK" and clickable[x] and clickable[x][y] then
		if bstate == NcurseIo.button1DoubleClick then
			local cont, cards <const> = clickable[x][y]:clickMe({},clickable,stacks)
			if cont and #cards > 0 then return doubleClick(cards,clickable,stacks) end
			return cont,{}
		end
		if bstate == NcurseIo.button1Clicked then
			return clickable[x][y]:clickMe(current,clickable,stacks)
		end
	end
	if ch == "q" then
		return false
	end
	return true,{}
end

function Input:continueGame()
	local input <const> = self:getUserInput()
	return input == "Y" or input == "y"
end

return Input
