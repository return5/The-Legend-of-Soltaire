local CardAddValuesTbl <const> = require('cardTbl.CardAddValuesTbl')
local CardAddValuesTblFalse <const> = require('cardTbl.CardAddValuesTblFalse')

return {
	RED = {RED = CardAddValuesTblFalse,BLUE = CardAddValuesTbl,NONE = CardAddValuesTbl},
	BLUE = {RED = CardAddValuesTbl, BLUE = CardAddValuesTblFalse,NONE = CardAddValuesTbl},
	NONE = {RED = CardAddValuesTbl, BLUE = CardAddValuesTbl,NONE = CardAddValuesTbl}
}



