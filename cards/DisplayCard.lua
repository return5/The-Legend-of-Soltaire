local Card <const> = require('cards.Card')
local Output <const> = require("io.Output")
local CardAddTbl <const> = require('cardTbl.CardAddTbl')
local rep <const> = string.rep
local ceil <const> = math.ceil
local setmetatable <const> = setmetatable
local tostring <const> = tostring

local DisplayCard <const> = {}
DisplayCard.__index = DisplayCard
setmetatable(DisplayCard,Card)

_ENV = DisplayCard

function DisplayCard:displayValue()
	Card.printOutline(self)
	Output:attron(self.color)
	Output:printLine(self.x + 1,self.y + 1,self.bodyDisplayRow)
	Output:printLine(self.x + 1,self.y + self.middleY,self.bodyMiddleDisplay)
	Output:printLine(self.x + 1,self.y + self.height - 1,self.bodyDisplayRow)
	Output:attroff(self.color)
end

function DisplayCard:grabMiddleCard()
	local cards <const> = {self}
	for i = self.index + 1,#self.stack.cards,1 do
		if cards[#cards]:addCardToThisCard(self.stack.cards[i],CardAddTbl) then
			cards[#cards + 1] = self.stack.cards[i]
		else
			return true,{}
		end
	end
	return true,cards
end

function DisplayCard:grabBottomCard()
	return true,{self}
end

function DisplayCard:setVisible()
	self.print = DisplayCard.displayValue
end

function DisplayCard:getY()
	 return ceil(self.y + (self.height / 2) - 1)
end

function DisplayCard:new(x,y,suite,value,width,height,showOutline)
	local o = setmetatable(Card:new(x,y,suite,value,width,height,showOutline),self)
	o.color = Output:getColor(suite)
	o.middleY = ceil(height / 2)
	local stringValue <const> = tostring(value)
	o.bodyDisplayRow = stringValue .. rep(" ",ceil(width - 2 - (stringValue:len() * 2))) .. stringValue
	local middleSpace <const> = rep(" ",ceil((width/2) - 1 - stringValue:len()))
	o.bodyMiddleDisplay = middleSpace .. stringValue .. middleSpace
	return o
end


return DisplayCard
