local Stack <const> = require('stacks.Stack')
local AceStackCardTbl <const> = require('cardTbl.AceStackCardTbl')

local setmetatable <const> = setmetatable 
local AceStack <const> = {}
AceStack.__index = AceStack
setmetatable(AceStack,Stack)
_ENV = AceStack

AceStack.tbl = AceStackCardTbl

function AceStack:print()
	self.displayCard:print()
end

local function checkWinConditions(stacks)
	for i=1,4,1 do
		if #stacks[i].cards < 14 then
			return true
		end
	end
	return false
end

--try to add current selection of cards to this stack
function AceStack:putCards(cards,clickable,stacks)
	if self.cards[#self.cards]:addCardToThisCard(cards[1],self.tbl) then
		self:addCard(cards[1],clickable)
		return checkWinConditions(stacks),{}
	end
	return true,{}
end

function AceStack:removeBottomCard(clickable)
	self.cards[#self.cards] = nil
	self.displayCard = self.cards[#self.cards]
	self.displayCard:addClickable(clickable)
end

--add new card to this stack
function AceStack:addCard(card,clickable)
	card.stack:removeBottomCard(clickable)
	card.x = self.x
	card.y = self.y
	self.cards[#self.cards + 1] = card
	self.displayCard = card
	card.stack = self
	card:addClickable(clickable)
	card.addCard = card.addCardBottom
	card.grabCard = card.grabBottomCard
end

function AceStack:new(x,y,width,height,clickable)
	local o <const> = setmetatable(Stack:new(x,y,width,height),self)
	o.invisibleCard.showOutline = true
	o.invisibleCard.print = o.invisibleCard.printOutline
	o.invisibleCard.stack = o
	o.displayCard = o.invisibleCard
	o.invisibleCard.addCard = o.invisibleCard.addCardBottom
	o.cards[1] = o.invisibleCard
	o.name = "ace"
	o.invisibleCard:addClickable(clickable)
	return o
end

return AceStack
