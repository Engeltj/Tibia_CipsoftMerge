local function inElevator(cid, position, fl)
	local flag = 0
	for x = 1, #fl do
		if (position.x == fl[x].x and position.y == fl[x].y and position.z == fl[x].z) then
			flag = 1
		end
	end
	if flag == 0 then
		doPlayerSendCancel(cid, "Step in elevator first!")
		doSendMagicEffect(position, CONST_ME_POFF)
		return false
	end
	return true
end

function onUse(cid, item, frompos, item2, topos)
	if item.itemid == 9825 then
		doTransformItem(item.uid, item.itemid+1)
	else
		doTransformItem(item.uid, item.itemid-1)
	end
	
	local storage = 1
	local fl = {
		{x = 2589, y = 2361, z = 8, stackpos = 1},
		{x = 2589, y = 2361, z = 9, stackpos = 1},
		{x = 2588, y = 2392, z = 9, stackpos = 1},
		{x = 2588, y = 2392, z = 10, stackpos = 1},
		{x = 2588, y = 2392, z = 11, stackpos = 1},
		{x = 2588, y = 2392, z = 12, stackpos = 1}
	}
	local position = getPlayerPosition(cid)
	if not inElevator(cid, position, fl) then
		return false
	end
	
	if (position.x == fl[1].x and position.y == fl[1].y and position.z == fl[1].z) then
		doTeleportThing(cid, {x = position.x, y = position.y, z = position.z + 1})
	elseif (position.x == fl[2].x and position.y == fl[2].y and position.z == fl[2].z) then
		doTeleportThing(cid, {x = position.x, y = position.y, z = position.z - 1})
	else
		if (position.x == fl[3].x and position.y == fl[3].y and position.z == fl[3].z) then
			setPlayerStorageValue(cid, storage, 1)
		elseif (position.x == fl[6].x and position.y == fl[6].y and position.z == fl[6].z) then
			setPlayerStorageValue(cid, storage, 0)
		end	
		
		if getPlayerStorageValue(cid, storage) == 1 and inElevator(cid, position, fl) then	
			doTeleportThing(cid, {x = position.x, y = position.y, z = position.z + 1})
		elseif getPlayerStorageValue(cid, storage) == 0 and inElevator(cid, position, fl) then
			doTeleportThing(cid, {x = position.x, y = position.y, z = position.z - 1})
		end
	end
	doSendMagicEffect(getPlayerPosition(cid), 12)
	return true
end