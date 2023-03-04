local Stack <const> = require('stacks.Stack')
local remove <const> = table.remove
local insert <const> = table.insert

local setmetatable <const> = setmetatable 
local DrawStack <const> = {}
DrawStack.__index = DrawStack
setmetatable(DrawStack,Stack)
_ENV = DrawStack

function DrawStack:print()
	self.displayCard:print()
end

local function grabCard(card,clickable)
	remove(card.stack.cards)
	card.stack:setDisplayCard(card.stack.cards[#card.stack.cards],clickable)
	card.stack:addToGrabStack(card,clickable)
	return true,{}
	end

function DrawStack:setCardToThisStack(card)
	card.x = self.x
	card.y = self.y
	card.addCard = grabCard
	card.grabCard = grabCard
	card.stack = self
end

function DrawStack:addToDiscardPile(card,clickable)
	card:removeClickable(clickable)
	self.discardPile[#self.discardPile + 1] = card
	self:setCardToThisStack(card)
end

function DrawStack:addToGrabStack(card,clickable)
	self.grabStack:addCard(card,clickable)
end

function DrawStack:setDisplayCard(card,clickable)
	self.displayCard = card
	if self.invisibleCard ~= card then
		card.print = card.printOutline
	end
	card:addClickable(clickable)
end

function DrawStack:initCards(cards)
	for i=1,#cards,1 do
		self:setCardToThisStack(cards[i])
	end
end

function DrawStack:resetCards(newCards)
	self.cards = {}
	for i=#newCards,1,-1 do
		self.cards[#self.cards + 1] = newCards[i]
		self:setCardToThisStack(newCards[i])
	end
end

local function resetDeck(card,clickable)
	local cards <const> = card.stack.grabStack:getCards(clickable)
	card.stack:resetCards(cards)
	insert(card.stack.cards,1,card)
	card.stack:setDisplayCard(card.stack.cards[#card.stack.cards],clickable)
	return true,{}
end

 function DrawStack:new(x,y,width,height,cards,clickable,grabStack)
	local o <const> = setmetatable(Stack:new(x,y,width,height),self)
	 o.cards = cards
	 o.name = "Draw"
	 o.grabStack = grabStack
	 o:initCards(cards)
	 o.invisibleCard.stack = o
	 o.invisibleCard.print = o.invisibleCard.printNoOutline
	 o.invisibleCard.addCard = resetDeck
	 o.invisibleCard.grabCard = resetDeck
	 o:setDisplayCard(cards[#cards],clickable)
	 insert(cards,1,o.invisibleCard)
	return o
end

return DrawStack
