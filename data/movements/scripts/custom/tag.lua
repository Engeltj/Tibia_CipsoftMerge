function onStepIn(cid, item, position, fromPosition)
	if not (item.itemid == 1945 or item.itemid == 1946) then
		local lookType = getPlayerStorageValue(cid, 16006)
		local lookHead = getPlayerStorageValue(cid, 16007)
		local lookBody = getPlayerStorageValue(cid, 16008)
		local lookLegs = getPlayerStorageValue(cid, 16009)
		local lookFeet = getPlayerStorageValue(cid, 16010)
		local lookAddons = getPlayerStorageValue(cid, 16011)
		if (lookType >= 0) then
			local outfit = {lookType = lookType, lookHead = lookHead,lookBody = lookBody, lookLegs = lookLegs,lookFeet = lookFeet,lookAddons = lookAddons}
			doSetCreatureOutfit(cid,outfit)
		end
		setPlayerStorageValue(cid, 16005, -1)
		setPlayerStorageValue(cid, 16006, -1)
		setPlayerStorageValue(cid, 16007, -1)
		setPlayerStorageValue(cid, 16008, -1)
		setPlayerStorageValue(cid, 16009, -1)
		setPlayerStorageValue(cid, 16010, -1)
		setPlayerStorageValue(cid, 16011, -1)
		unregisterCreatureEvent(cid, "Tag")
	end
	return true
end