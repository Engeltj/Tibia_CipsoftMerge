function onUse(cid, item, fromPosition, itemEx, toPosition)
	local player = Player(cid)
	if player:getStorageValue(Storage.ExplorerSociety.QuestLine) == 42 then
		player:setStorageValue(Storage.ExplorerSociety.QuestLine, 43)
		player:addItem(4853, 1)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have found a sheet of tracing paper.")
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The chest is empty.")
	end
	return true
end
