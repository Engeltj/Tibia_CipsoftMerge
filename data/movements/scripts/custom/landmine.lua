function onStepIn(cid, item, toPos, itemEx, fromPos)
	local hit = math.random(1,10)
	if hit > 7 then
		local creature = Creature(cid)
		local mine = Item(item.uid)
		creature:addHealth(creature:getHealth()*-1)
		mine:remove()
		addEvent(doCreateItem, 60*1000*5, 10572, 1, toPos)
		Position(toPos):sendMagicEffect(1)
	end
	return true
end	
		
function onStepOut(cid, item, toPos, fromPos)
	local creature = Creature(cid)
	local mine = Item(item.uid)
	creature:addHealth(creature:getHealth()*-1)
	mine:remove()
	--addEvent(doCreateItem, 60*1000*5, 10572, 1, fromPos)
	Position(fromPos):sendMagicEffect(5)
	Position(toPos):sendMagicEffect(1)
	return true
end