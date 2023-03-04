local setmetatable <const> = setmetatable
local rep <const> = string.rep
local Output <const> = require('io.Output')
local concat <const> = table.concat

local Card <const> = {}
Card.__index = Card
_ENV = Card

function Card:grabMiddleCard()
	return true,{}
end

function Card:grabBottomCard()
	return true,{}
end

function Card:toString()
	return concat({self.x,":",self.y,";",self.suite,":",self.value})
end

function Card:addCardBottom(clickable,cards,stacks)
	return self.stack:putCards(cards,clickable,stacks)
end

function Card:addCardToThisCard(card,tbl)
	return tbl[self.suite][card.suite][self.value][card.value]
end

function Card:addCardMiddle()
	return true,{}
end

function Card:printBold()
	Output:boldOn()
	self:print()
	Output:boldOff()
end

function Card:clickMe(cards,clickable,stacks)
	if not cards or #cards == 0 then
		return self:grabCard(clickable,stacks)
	else
		return self:addCard(clickable,cards,stacks)
	end
end

function Card:addCard()
	return true,{}
end

local function printCard(top,row,x,y,height)
	Output:printLine(x,y,top)
	Output:printLine(x,y + height,top)
	for i=y + 1,y + height - 1,1 do
		Output:printLine(x,i,row)
	end
end

function Card:setVisible()
	--do nothing
end

function Card:getY()
	return self.y
end

function Card:printNoOutline()
	printCard(self.bodyEmpty,self.bodyEmpty,self.x,self.y,self.height)
end

function Card:printOutline()
	printCard(self.bodyTop,self.bodyRow,self.x,self.y,self.height)
end

function Card:removeClickable(clickable)
	for i = self.x,self.x + self.width - 1,1 do
		for j = self.y,self.y + self.height - 1,1 do
			clickable[i][j] = nil
		end
	end
end

function Card:addClickable(clickable)
	for i = self.x,self.x + self.width - 1,1 do
		if not clickable[i] then clickable[i] = {} end
		for j = self.y,self.y + self.height - 1,1 do
			clickable[i][j] = self
		end
	end
end

function Card:new(x,y,suite,value,width,height,showOutline)
	local o <const> = setmetatable({x = x, y = y,suite = suite,value = value,width = width,height = height},self)
	o.print = showOutline and Card.printOutline or Card.printNoOutline
	o.bodyRow = "|" .. rep(" ",width - 2) .. "|"
	o.bodyTop = rep("-",width)
	o.bodyEmpty = rep(" ",width)
	o.addCard = Card.addCardMiddle
	o.grabCard = Card.grabMiddleCard
	return o
end

return Card
