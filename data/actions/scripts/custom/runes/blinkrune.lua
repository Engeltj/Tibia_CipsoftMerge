local function isWalkable(fromPos, toPos)
--	if (fromPos.x > toPos.x) and (fromPos.y > toPos.y) then -- top left
--		local y = deepcopy(fromPos.y)
--	elseif (fromPos.x > toPos.x) and (fromPos.y == toPos.y) then -- center left
	
--	elseif (fromPos.x > toPos.x) and (fromPos.y > toPos.y) then-- bottom left
	
--	elseif (fromPos.x == toPos.x) and (fromPos.y < toPos.y) then-- bottom center
	
--	elseif (fromPos.x < toPos.x) and (fromPos.y > toPos.y) then-- bottom right
	
--	elseif (fromPos.x < toPos.x) and (fromPos.y == toPos.y) then-- center right
	
	--elseif (fromPos.x < toPos.x) and (fromPos.y > toPos.y) then-- top right
	
	--elseif (fromPos.x == toPos.x) and (fromPos.y > toPos.y) then-- top center
	
--	end

	return true
end

function onUse(cid, item, fromPosition, itemEx, toPosition)
	local playerPos = getPlayerPosition(cid)
	if isWalkable(fromPosition, toPosition) then
		doSendMagicEffect(playerPos, 2)
		doRemoveItem(item.uid, 1)
		doTeleportThing(cid, getThingPosition(itemEx.uid), false)
		doSendMagicEffect(getPlayerPosition(cid), 12)
	--else
	--	doSendMagicEffect(playerPos, 2)
	end
	return true
end
