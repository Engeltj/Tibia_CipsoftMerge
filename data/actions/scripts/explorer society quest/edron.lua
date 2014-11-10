function onUse(cid, item, fromPosition, itemEx, toPosition)
	local player = Player(cid)
	if player:getStorageValue(Storage.ExplorerSociety.QuestLine) == 39 then
		player:setStorageValue(Storage.ExplorerSociety.QuestLine, 40)
		player:addItem(4852, 1)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have found a memory stone.")
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The chest is empty.")
	end
	return true
end
