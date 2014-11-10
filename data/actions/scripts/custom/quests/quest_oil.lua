function onUse(cid, item, fromPosition, itemEx, toPosition)
	if tonumber(getPlayerStorageValue(cid, 15000)) >= 0 then
		if getPlayerStorageValue(cid, item.uid) == -1 then
			local closed = getPlayerStorageValue(cid, 15000)+1
			local leftToGo = 7 - closed
			setPlayerStorageValue(cid, item.uid, 1)
			if leftToGo > 0 then
				doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "You have closed this valve. There are " .. leftToGo.. " left to close.")
			else
				doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "You've closed all the valves! Please let Richard know that the extractors have been contained.")
			end
			doSendMagicEffect(getPlayerPosition(cid), 12)
			setPlayerStorageValue(cid, 15000, closed)
		else
			doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "This valve appears to be closed.")
			doSendMagicEffect(getPlayerPosition(cid), 2)
		end
	end
	return true
end