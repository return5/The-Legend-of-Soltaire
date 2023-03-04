local setmetatable <const> = setmetatable
local Card <const> = require('cards.Card')

local Stack <const> = {}
Stack.__index = Stack
_ENV = Stack

function Stack:checkIfCanAdd(card)
	return self.cards[#self.cards]:addCardToThisCard(card,self.tbl)
end


function Stack:new(x,y,cardWidth,cardHeight)
	local o = setmetatable({x = x,y = y,cards = {}},self)
	o.invisibleCard = Card:new(o.x,o.y,"NONE",1,cardWidth,cardHeight,false)
	return o
end

return Stack
