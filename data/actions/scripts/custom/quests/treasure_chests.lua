
function onUse(cid, item, fromPosition, itemEx, toPosition)
	local x=math.random(5,15) * getPlayerLevel(cid)
	--doTransformItem(item.uid, 1740)
	doRemoveItem(item.uid, 1)
	toPosition.stackpos = 255
	local tempchest = doCreateItem(1740, toPosition)
	doItemSetAttribute(tempchest, 'aid', 0)
	doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You found " ..x.." gp in hidden treasure!")
	doPlayerAddMoney(cid, x)
	doSendMagicEffect(fromPosition, 12)
	addEvent(treasure_reset, math.random(30,65)*60*1000, toPosition, tempchest)
	return true
end

function treasure_reset(pos, chest)
	local used_chest = getTileItemById(pos, 1740)
	if used_chest.itemid == 1740 then
		doRemoveItem(used_chest.uid, 1)
	end
	
	doSendMagicEffect(pos, 12)
	local item = doCreateItem(5676, pos)
	doItemSetAttribute(item, 'aid', 2016)
	--doTileAddItemEx(pos, item)

end

-- function reset() 
	-- --local pos1 = {x = 497, y = 459, z = 7} -- Coordinates for the thing to re-appear
	-- local item1 = 5676 -- ID of the item to appear
	-- local item = doTransformItem(item.uid, 5675)
	-- doSendMagicEffect(frompos, 13)
-- end