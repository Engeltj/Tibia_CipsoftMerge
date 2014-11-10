-- function countDown(cid, seconds)
	-- doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, seconds .. " left.")
	-- if (seconds > 0) then
		-- addEvent(countDown, cid, seconds-1)
	-- end
	-- return
-- end


function onSay(cid, words, param)
	local param = string.explode(param, "exiva ")
	
	if(param == '') then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Please specify a player name")
		return true
	end
	
	local old_pos = getPlayerPosition(cid)
	local playerEx = getCreatureByName(param[1])
	local group = getPlayerGroupId(cid)
	local wait = 20 - (os.time() - tonumber(getPlayerStorageValue(cid, 1705))) or 0
	if group ~= 2 and playerEx ~= false and isPlayer(playerEx) and wait <= 0 then
		if not (getPlayerGroupId(playerEx) == 2) and getPlayerGroupId(playerEx) < 5 then
			doCreatureSetStorage(cid, 1701, group)
			doCreatureSetStorage(cid, 1702, old_pos.x)
			doCreatureSetStorage(cid, 1703, old_pos.y)
			doCreatureSetStorage(cid, 1704, old_pos.z)
			doPlayerSetGroupId(cid, 2)
			doSendMagicEffect(old_pos, 6)
			doTeleportThing(cid, getPlayerPosition(playerEx), false)
			--addEvent(countDown, cid, 10)
			addEvent(deSpy, 10000, cid)
			doMutePlayer(cid, 11)
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You are now spying for 10 seconds.")
			setPlayerStorageValue(cid, 1705, os.time())
		elseif getPlayerGroupId(playerEx) >= 5 then
			doPlayerSendCancel(cid, "This player does not allow being spied upon.")
			doSendMagicEffect(old_pos, 2)
		else
			doPlayerSendCancel(cid, "Player is currently spying :)")
			doSendMagicEffect(old_pos, 2)
		end
	elseif group == 2 then
		doPlayerSendCancel(cid, "You are currently a spy.")
	elseif wait > 0 then
		doPlayerSendCancel(cid, "You must wait " .. wait .. " more second(s) before using this again.")
		doSendMagicEffect(old_pos, 2)
	else
		doPlayerSendCancel(cid, "Player not found.")
		doSendMagicEffect(old_pos, 2)
	end
	return true
end