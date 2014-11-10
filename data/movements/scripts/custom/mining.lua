function onStepIn(cid, item, position, fromPosition)
	local direction = fromPosition.x - position.x
	if direction < 0 then
		local pos = position
		pos.x = pos.x + 1
		pos.stackpos = 255
		doPlayerSendCancel(cid, fromPosition.x-pos.x)
		if isPlayer(getThingFromPosition(pos).uid) and fromPosition.x - pos.x ~= 0 then
			doTeleportThing(cid, fromPosition, false)
		end
		return true
	else
		local pos = position
		pos.x = pos.x - 1
		pos.stackpos = 255
		doPlayerSendCancel(cid, fromPosition.x-pos.x)
		if isPlayer(getThingFromPosition(pos).uid) and fromPosition.x - pos.x ~= 0 then
			doTeleportThing(cid, fromPosition, false)
		end
	end
end