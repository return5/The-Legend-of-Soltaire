local Stack <const> = require('stacks.Stack')
local CardAddTbl <const> = require('cardTbl.CardAddTbl')

local setmetatable <const> = setmetatable

local PlayStack <const> = {}
PlayStack.__index = PlayStack
setmetatable(PlayStack,Stack)
_ENV = PlayStack

PlayStack.tbl = CardAddTbl

function PlayStack:print()
	for i=1,#self.cards,1 do
		self.cards[i]:print()
	end
end

--try to add current selection of cards to this stack
function PlayStack:putCards(cards,clickable)
	for i =1,#cards,1 do
		if self.cards[#self.cards]:addCardToThisCard(cards[i],self.tbl) then
			self:addCard(cards[i],clickable)
		else
			return true,{}
		end
	end
	return true,{}
end

function PlayStack:removeBottomCard(clickable)
	if #self.cards > 2 then
		self.cards[#self.cards]:removeClickable(clickable)
	else
		self.cards[1]:addClickable(clickable)
	end
	self.cards[#self.cards] = nil
	self.cards[#self.cards].addCard = self.cards[#self.cards].addCardBottom
	self.cards[#self.cards].grabCard = self.cards[#self.cards].grabBottomCard
	self.cards[#self.cards]:setVisible()
	self.cards[#self.cards]:addClickable(clickable)
end

local function addNewCardToStack(newCard,stack,clickable)
	newCard.stack = stack
	newCard.x = stack.cards[#stack.cards].x
	newCard.y = stack.cards[#stack.cards]:getY()
	stack.cards[#stack.cards + 1] = newCard
	newCard.index = #stack.cards
	newCard:addClickable(clickable)
end

--add new card to this stack
function PlayStack:addCard(card,clickable)
	local current <const> = self.cards[#self.cards]
	current.addCard = current.addCardMiddle
	current.grabCard = current.grabMiddleCard
	card.addCard = card.addCardBottom
	card.grabCard = card.grabBottomCard
	card.stack:removeBottomCard(clickable)
	addNewCardToStack(card,self,clickable)
end

function PlayStack:initCards(cards,clickable)
	self.cards[1] = self.invisibleCard
	for i=1,#cards,1 do
		addNewCardToStack(cards[i],self,clickable)
		cards[i].grabCard = cards[i].grabMiddleCard
		cards[i].addCard = cards[i].addCardBottom
		cards[i].index = i + 1
	end
	self.cards[#self.cards].addCard = self.cards[#self.cards].addCardBottom
	self.cards[#self.cards].grabCard = self.cards[#self.cards].grabBottomCard
	self.cards[#self.cards]:setVisible()
end

function PlayStack:new(x,y,cards,width,height,clickable)
	local o = setmetatable(Stack:new(x,y,width,height),self)
	o:initCards(cards,clickable)
	o.name = "Stack"
	o.invisibleCard.addCard = o.invisibleCard.addCardBottom
	o.invisibleCard.stack = o
	return o
end

return PlayStack
