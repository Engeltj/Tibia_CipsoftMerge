function onSay(cid, words, param)
	local param = string.explode(param, " ")
	local bail = getPlayerStorageValue(cid, 16004)
	local funds = getPlayerBalance(cid)
	if (bail <= 1) then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You do not need to be bailed out.")
		return true
	end
	if not ((funds - bail) > 0) then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Insufficient funds in bank, bail denied.")
		return true
	end
	
	if #param ~= 1 then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Price to bail is "..doNumberFormat(bail).. "gps. Type {!bail now} to bail.")
		return true
	elseif (param[1] == "now") then
		if (doPlayerRemoveMoney(cid, bail)) then
			local releasePos = {x=2251,y=2287,z=6}
			doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "You have been released from jail.")
			setPlayerStorageValue(cid, 16004, -1)
			doTeleportThing(cid, releasePos)
			doSendMagicEffect(releasePos, 12)
		else
			doPlayerSendCancel(cid, "Failed to pay the bail.")
			doSendMagicEffect(getPlayerPosition(cid), 2)
		end
		return true
	end
	doCreatureSetStorage(cid, tonumber(param[1]), tonumber(param[2]))
	
	return true
end
