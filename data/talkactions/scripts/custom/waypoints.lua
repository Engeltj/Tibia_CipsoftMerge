function onSay(cid, words, param)
	local found = 0
	if param ~= "" then
		for i, dst in ipairs(waypoints) do
			if string.lower(param) == string.lower(dst.name) then
				local storage = 20000+i-1
				local player_pos = getPlayerPosition(cid)
				player_pos.stackpos = 0
				local tile = getThingFromPosition(player_pos)
				if getPlayerStorageValue(cid, storage) == 1 then
					if getItemAttribute(tile.uid, "aid") == 2200 then
						local pos = {x=dst.x,y=dst.y,z=dst.z,stackpos=255}
						doSendMagicEffect(getPlayerPosition(cid), CONST_ME_POFF)
						doTeleportThing(cid, pos, false)
						doSendMagicEffect(getPlayerPosition(cid), 12)
					else
						doPlayerSendCancel(cid, "You must stand on a waypoint tile first.")
						doSendMagicEffect(getPlayerPosition(cid), CONST_ME_POFF)
						return true
					end
				else
					doPlayerSendCancel(cid, "You have not unlocked this location yet.")
				end
				found = 1
			end
		end
	end
	local available_travel = ""
	for i, dst in ipairs(waypoints) do
		local storage = 20000+i-1
		if getPlayerStorageValue(cid, storage) == 1 then
			if (available_travel ~= "") then
				available_travel = available_travel .. "\n      - " .. deepcopy(dst.name)
			else
				available_travel = "      - "..deepcopy(dst.name)
			end
		end
	end
	if param ~= "" and found == 0 then
		doPlayerSendCancel(cid, "Invalid location.")
		doSendMagicEffect(getPlayerPosition(cid), 2)
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "You may travel to:\n" .. available_travel)
	elseif param == "" then
		doPlayerPopupFYI(cid, "You may travel to:\n" .. available_travel)
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "You may travel to:\n" .. available_travel)
	end
	
	return true
end