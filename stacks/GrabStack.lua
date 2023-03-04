local Stack <const> = require('stacks.Stack')

local setmetatable <const> = setmetatable 
local GrabStack <const> = {}
GrabStack.__index = GrabStack
setmetatable(GrabStack,Stack)
_ENV = GrabStack

function GrabStack:print()
	self.displayCard:print()
end

function GrabStack:getCards(clickable)
	local temp <const> = self.cards
	self.displayCard = self.invisibleCard
	self.displayCard:addClickable(clickable)
	self.cards = {}
	return temp
end

function GrabStack:removeBottomCard(clickable)
	self.displayCard:removeClickable(clickable)
	self.cards[#self.cards] = nil
	self.displayCard = #self.cards > 0 and self.cards[#self.cards] or self.invisibleCard
	self.displayCard:addClickable(clickable)
end

function GrabStack:addCard(card,clickable)
	card.stack = self
	card.x = self.x
	card.y = self.y
	self.displayCard = card
	self.displayCard:setVisible()
	self.displayCard.grabCard = self.displayCard.grabBottomCard
	self.displayCard.addCard = self.displayCard.grabBottomCard
	card:addClickable(clickable)
	self.cards[#self.cards + 1] = card
end

 function GrabStack:new(x,y,width,height)
	 local o <const> = setmetatable(Stack:new(x,y,width,height),self)
	 o.displayCard = o.invisibleCard
	 o.cards = {}
	 o.name = "grab"
	 return o
end

return GrabStack
