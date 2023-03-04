local AceStack <const> = require('stacks.AceStack')
local DrawStack <const> = require('stacks.DrawStack')
local PlayStack <const> = require('stacks.PlayStack')
local GrabStack <const> = require('stacks.GrabStack')
local Deck <const> = require('cards.Deck')

local Factory <const> = {}
Factory.__index = Factory
_ENV = Factory

function Factory:initGame(width,height)
	local deck <const> = Deck:new(height,width)
	local stacks <const> = {}
	local clickable <const> = {}
	local spacing <const> = 4
	local drawX <const> = 2
	local drawY <const> = 0
	local cardCount <const> = 12
	local playY <const> = drawY + height + 5
	local x = drawX
	for i=5,11,1 do
		stacks[i] = PlayStack:new(x,playY,deck:grabCards(cardCount - i),width,height,clickable)
		x = stacks[i].x + width + spacing
	end
	x = stacks[8].x
	for i=1,4,1 do
		stacks[i] = AceStack:new(x,drawY,width,height,clickable)
		x = stacks[i].x + width + spacing
	end
	stacks.grab = GrabStack:new(drawX + width + spacing,drawY,width,height)
	stacks.draw = DrawStack:new(drawX,drawY,width,height,deck:grabCards(#deck.cards),clickable,stacks.grab)
	return stacks,clickable
end

return Factory
