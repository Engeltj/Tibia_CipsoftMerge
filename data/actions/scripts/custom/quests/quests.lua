function onUse(cid, item, fromPosition, itemEx, toPosition)
	if (getPlayerGroupId(cid) == 2) then
		return true
	end
	local ret = getItemDescriptions(item.uid)
	if item.actionid == 2036 then
		if (tonumber(getPlayerStorageValue(cid, 15901)) == 2) then
			local itemPos = getThingPosition(item.uid)
			local playerPos = getPlayerPosition(cid)
			if item.itemid == 5288 then
				if (playerPos.x < itemPos.x) then
					playerPos.x = playerPos.x + 2
				else
					playerPos.x = playerPos.x - 2
				end
				playerPos.y = itemPos.y
			else
				if (playerPos.y < itemPos.y) then
					playerPos.y = playerPos.y + 2
				else
					playerPos.y = playerPos.y - 2
				end
				playerPos.x = itemPos.x
			end
			doTeleportThing(cid, playerPos)
			doSendMagicEffect(playerPos, 12)
		else
			doSendMagicEffect(getCreaturePosition(cid), 2)
		end
		return true
	end
	
	if item.uid >= 15008 and item.uid <=15011 then
		local storage = getPlayerStorageValue(cid, 15012)
		local pos = getPlayerPosition(cid)
		local newpos = {x=2703,y=2439,z=14}
		if storage == -1 and item.uid == 15008 then 
			setPlayerStorageValue(cid, 15012, 1)
			doSendMagicEffect(pos, 12)
		elseif storage == 1 and item.uid == 15009 then 
			setPlayerStorageValue(cid, 15012, 2)
			doSendMagicEffect(pos, 12)
		elseif storage == 2 and item.uid == 15010 then 
			setPlayerStorageValue(cid, 15012, 3)
			doSendMagicEffect(pos, 12)
		elseif storage == 3 and item.uid == 15011 then 
			setPlayerStorageValue(cid, 15012, -1)
			doTeleportThing(cid, newpos)
			doSendMagicEffect(newpos, 12)
		else
			doSendMagicEffect(pos, 2)
			setPlayerStorageValue(cid, 15012, -1)
		end
		return true
	end
	
	if item.uid == 2404 and getPlayerStorageValue(cid, item.uid) ~= 1 then
		local reward = getThing(doCreateItemEx(item.uid,1))
		local ret = getItemDescriptions(reward.uid)
		setItemDefense(reward.uid,8)
		setItemAttack(reward.uid,8)
		doPlayerAddItemEx(cid, reward.uid, false)
		setPlayerStorageValue(cid, item.uid, 1)
		result = "You have found " .. ret.article .. " " .. ret.name .. "."
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, result)	
	elseif item.uid == 2406 and getPlayerStorageValue(cid, item.uid) ~= 1 then
		local reward = getThing(doCreateItemEx(item.uid,1))
		local ret = getItemDescriptions(reward.uid)
		setItemDefense(reward.uid,48)
		setItemAttack(reward.uid,42)
		doPlayerAddItemEx(cid, reward.uid, false)
		setPlayerStorageValue(cid, item.uid, 1)
		result = "You have found " .. ret.article .. " " .. ret.name .. "."
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, result)
	elseif item.uid == 2458 and getPlayerStorageValue(cid, item.uid) ~= 1 then
		local reward = getThing(doCreateItemEx(item.uid,1))
		local ret = getItemDescriptions(reward.uid)
		setItemArmor(reward.uid,56)
		doPlayerAddItemEx(cid, reward.uid, false)
		setPlayerStorageValue(cid, item.uid, 1)
		result = "You have found " .. ret.article .. " " .. ret.name .. "."
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, result)
	elseif item.uid == 2482 and getPlayerStorageValue(cid, item.uid) ~= 1 then
		local reward = getThing(doCreateItemEx(item.uid,1))
		local ret = getItemDescriptions(reward.uid)
		setItemArmor(reward.uid, 35)
		doPlayerAddItemEx(cid, reward.uid, false)
		setPlayerStorageValue(cid, item.uid, 1)
		result = "You have found " .. ret.article .. " " .. ret.name .. "."
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, result)
	elseif item.uid == 5917 and getPlayerStorageValue(cid, item.uid) ~= 1 then
		local reward = getThing(doCreateItemEx(item.uid,1))
		local ret = getItemDescriptions(reward.uid)
		setItemArmor(reward.uid, 46)
		doPlayerAddItemEx(cid, reward.uid, false)
		setPlayerStorageValue(cid, item.uid, 1)
		result = "You have found " .. ret.article .. " " .. ret.name .. "."
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, result)
	else
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "The " .. ret.name .. " is empty.")
	end
	return true
end

