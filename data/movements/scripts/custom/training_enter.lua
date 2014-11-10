function onStepIn(cid, item, position, fromPosition)
	local rooms = {
		{x = 2246,y = 2260,z = 5},
		{x = 2265,y = 2261,z = 5},
		{x = 2256,y = 2247,z = 4},
		{x = 2261,y = 2247,z = 4}
	}
	local empty_room = { }
	local send_pos = getPlayerPosition(cid)
	local flag = 0
	if ((Player(cid):getCondition(CONDITION_INFIGHT) == true) and (getTileInfo(send_pos).protection == false)) then
		doSendMagicEffect(send_pos, 2)
		doPlayerSendCancel(cid, "You may not do this while in battle.")
		return false
	end
	if item.actionid == 2002 then
		for a, b in ipairs(rooms) do
			local v = getTopCreature(b).uid
			if Player(v) == nil then
				table.insert(empty_room, b)
				flag = 1
			end
		end
		if flag == 1 then	-- Empty Room Teleport
			local dst = math.random(1,#empty_room)
			doSendMagicEffect(send_pos, 2)
			setPlayerStorageValue(cid, 1, send_pos.x+2)
			setPlayerStorageValue(cid, 2, send_pos.y)
			setPlayerStorageValue(cid, 3, send_pos.z)
			doTeleportThing(cid, empty_room[dst])
			doSendMagicEffect((empty_room[dst]), 12)
			--local portal = doCreateItem(1491, 1, {x = empty_room[dst].x, y = empty_room[dst].y + 1, z = empty_room[dst].z})
			--doSetItemActionId(portal, 2003)
		else
			doPlayerSendCancel(cid, "All training rooms are currently full! Try again later.")
			doSendMagicEffect(send_pos, 2)
		end
		if item.itemid == 9825 then
			doTransformItem(item.uid, item.itemid+1)
		elseif item.itemid == 9826 then
			doTransformItem(item.uid, item.itemid-1)
		end
		return true
	end
end