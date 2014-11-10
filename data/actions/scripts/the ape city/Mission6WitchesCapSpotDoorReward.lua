function onUse(cid, item, fromPosition, itemEx, toPosition)
	if item.itemid == 4183 then --reward
		local player = Player(cid)
		if player:getStorageValue(Storage.TheApeCity.Mission06) == 1 then
			player:setStorageValue(Storage.TheApeCity.Mission06, 2) -- The Ape City Questlog - Mission 6: Witches' Cap Spot
			player:addItem(4840, 1)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have found a Witches Cap Spot.")
		end
	end
	return true
end
