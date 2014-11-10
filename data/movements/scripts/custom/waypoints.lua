local f_addMark = doPlayerAddMapMark
if(not f_addMark) then f_addMark = doAddMapMark end

function addMarker(cid)
	if(isPlayer(cid) ~= TRUE or getPlayerStorageValue(cid, config.storage) == config.version) then
		return
	end

	for _, m  in pairs(config.marks) do
		f_addMark(cid, m.pos, m.mark, m.desc ~= nil and m.desc or "")
	end
	setPlayerStorageValue(cid, config.storage, config.version)
	return TRUE

end

function comparePos(cid, pos)
	for i, dst in ipairs(waypoints) do
		if (pos.x > (dst.x-6) and pos.x < (dst.x+6)) and (pos.y > (dst.y-6) and pos.y < (dst.y+6)) and (pos.z == dst.z) then
			return i
		end
	end
	return -1
end

function onStepIn(cid, item, toPos, fromPos)
	local match = comparePos(cid, toPos)
	local storage = 20000+match-1
	if isPlayer(cid) and match ~= -1 and getPlayerStorageValue(cid, storage) ~= 1 then
		doSendMagicEffect(getPlayerPosition(cid), 29)
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "You've unlocked a new !travel destination, " .. waypoints[match].name)
		--doPlayerSendTextMessage(cid, MESSAGE_STATUS_DEFAULT, "You've unlocked a new !travel destination, " .. waypoints[match].name)
		--doPlayerSendTextMessage(cid, MESSAGE_EXPERIENCE, "Unlocked!")
		setPlayerStorageValue(cid, storage, 1)
		local map_pos = {x=waypoints[match].x,y=waypoints[match].y,z=waypoints[match].z}
		--doPlayerAddMapMark(cid, map_pos, 5, waypoints[match].name)
	else
		doSendMagicEffect(getPlayerPosition(cid), 12)
	end
	return true
end