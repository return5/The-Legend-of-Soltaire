local DisplayCard <const> = require('cards.DisplayCard')
local random <const> = math.random

local setmetatable <const> = setmetatable

local Deck <const> = {}
Deck.__index = Deck
_ENV = Deck

local values <const> = {2,3,4,5,6,7,8,9,10,"A","K","Q","J"}
local colors <const> = {"BLUE","BLUE","RED","RED"}

function Deck:randomize()
	for i=#self.cards,2,-1 do
		local temp <const> = self.cards[i]
		local index <const> = random(i - 1)
		self.cards[i] = self.cards[index]
		self.cards[index] = temp
	end
end

function Deck:initDeck(height,width)
	for i=1,#colors,1 do
		for j=1,#values,1 do
			self.cards[#self.cards + 1] = DisplayCard:new(0,0,colors[i],values[j],width,height,true)
		end
	end
end

function Deck:reset()
	self.cards = self.discard
	self.discard = {}
	self:randomize()
end

function Deck:grabCards(n)
	local cards <const> = {}
	for i=1,n,1 do
		cards[i] = self.cards[#self.cards]
		self.discard[#self.discard] = cards[i]
		self.cards[#self.cards] = nil
	end
	return cards
end

function Deck:new(height,width)
	local o <const> = setmetatable({cards = {},discard = {}},self)
	o:initDeck(height,width)
	o:randomize()
	return o
end

return Deck
