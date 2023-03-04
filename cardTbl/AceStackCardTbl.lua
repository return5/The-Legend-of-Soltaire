local CardAddValuesTbl <const> = require('cardTbl.AceStackAddValuesTbl')
local CardAddValuesTblFalse <const> = require('cardTbl.CardAddValuesTblFalse')

return {
	RED = {RED = CardAddValuesTbl,BLUE = CardAddValuesTblFalse,NONE = CardAddValuesTbl},
	BLUE = {RED = CardAddValuesTblFalse, BLUE = CardAddValuesTbl,NONE = CardAddValuesTbl},
	NONE = {RED = CardAddValuesTbl, BLUE = CardAddValuesTbl,NONE = CardAddValuesTbl}
}

