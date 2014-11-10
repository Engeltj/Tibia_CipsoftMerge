unlockedDoors = { }

local function isDoorLocked(keyId, position)
	if keyId == 0 then
		return false
	end

	if unlockedDoors[keyId] then
		for i = 1, #unlockedDoors[keyId] do
			print(unlockedDoors[keyId][i].x)
			if position == unlockedDoors[keyId][i] then
				return false
			end
		end
	end

	return true
end

local function toggleDoorLock(doorItem, locked)
	local doorId = doorItem:getId()
	local keyId = doorItem:getActionId()
	local doorPosition = doorItem:getPosition()

	if locked then
		for i = #unlockedDoors[keyId], 1, -1 do
			if unlockedDoors[keyId][i] == doorPosition then
				table.remove(unlockedDoors[keyId], i)
			end
		end

		if not doors[doorId] then
			doorItem:transform(doorId - 1)
		end
		return
	end

	if not unlockedDoors[keyId] then
		unlockedDoors[keyId] = {}
	end

	doorItem:transform(doors[doorId])
	table.insert(unlockedDoors[keyId], doorPosition)
end

function onUse(cid, item, fromPosition, itemEx, toPosition)
	if isInArray(questDoors, item.itemid) then
		local player = Player(cid)
		if player:getStorageValue(item.actionid) ~= -1 then
			Item(item.uid):transform(item.itemid + 1)
			player:teleportTo(toPosition, true)
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The door seems to be sealed against unwanted intruders.")
		end
		return true

	elseif isInArray(levelDoors, item.itemid) then
		local player = Player(cid)
		if item.actionid > 0 and player:getLevel() >= item.actionid - 1000 then
			Item(item.uid):transform(item.itemid + 1)
			player:teleportTo(toPosition, true)
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Only the worthy may pass.")
		end
		return true

	elseif isInArray(keys, item.itemid) then
		if not ItemType(itemEx.itemid):isDoor() or isInArray(openSpecialDoors, itemEx.itemid)
				or isInArray(questDoors, itemEx.itemid) or isInArray(levelDoors, itemEx.itemid)
				or Tile(toPosition):getHouse() then
			return false
		end

		if itemEx.actionid > 0 and item.actionid == itemEx.actionid then
			if not isDoorLocked(itemEx.actionid, toPosition) then
				toggleDoorLock(Item(itemEx.uid), true)
			elseif doors[itemEx.itemid] then
				toggleDoorLock(Item(itemEx.uid), false)
			end
		else
			Player(cid):sendCancelMessage("The key does not match.")
		end
		return true
	end

	local tileToPos = toPosition:getTile()
	local thing = tileToPos:getThing(STACKPOS_TOP_MOVEABLE_ITEM_OR_CREATURE)
	if thing and item.uid ~= thing:getUniqueId() and fromPosition:getTile():getItemByType(ITEM_TYPE_MAGICFIELD) then
		return false
	end

	if isInArray(horizontalOpenDoors, item.itemid) or isInArray(verticalOpenDoors, item.itemid) then
		local doorCreature = tileToPos:getTopCreature()
		if doorCreature then
			toPosition.x = toPosition.x + 1
			local query = toPosition:getTile():queryAdd(doorCreature, 20)
			if query ~= RETURNVALUE_NOERROR then
				toPosition.x = toPosition.x - 1
				toPosition.y = toPosition.y + 1
				query = toPosition:getTile():queryAdd(doorCreature, 20)
			end

			if query ~= RETURNVALUE_NOERROR then
				Player(cid):sendCancelMessage(query)
				return true
			end

			doorCreature:teleportTo(toPosition, true)
		end
		if not isInArray(openSpecialDoors, item.itemid) then
			Item(item.uid):transform(item.itemid - 1)
		end
		return true
	end

	if doors[item.itemid] then
		if not isDoorLocked(item.actionid, toPosition) then
			Item(item.uid):transform(doors[item.itemid])
		else
			Player(cid):sendTextMessage(MESSAGE_INFO_DESCR, "It is locked.")
		end
		return true
	end

	return false
end