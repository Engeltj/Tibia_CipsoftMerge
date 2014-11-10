
function onUse(cid, item, frompos, item2, topos)
		local item = getThingFromPosition(topos)
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Stack " .. topos.stackpos .. "")
		return true
end