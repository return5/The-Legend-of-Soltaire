--[[
	Legend of soltaire - a very simple solitare clone.
    Copyright (C) <2023>  <return5>

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
--]]

local Input <const> = require('io.Input')
local Factory <const> = require('factory.Factory')
local Output <const> = require('io.Output')
local NcurseAux <const> = require('ncurses.NcursesAux')

local function gameLoop(clickable,stacks)
	local cont = true
	local currentSelection = {}
	while cont do
		Output:printCards(stacks,currentSelection)
		cont,currentSelection = Input:getInput(currentSelection,clickable,stacks)
	end
end

local function quitGame()
	Output:printEndGame()
	return Input:continueGame()
end

local function main()
	math.randomseed(os.time())
	local cardWidth <const> = 9
	local cardHeight <const> = 6
	NcurseAux:initNcurses()
	repeat
		local stacks,clickable <const> = Factory:initGame(cardWidth,cardHeight)
		gameLoop(clickable,stacks)
	until not quitGame()
	NcurseAux:endNcurses()
end

main()
