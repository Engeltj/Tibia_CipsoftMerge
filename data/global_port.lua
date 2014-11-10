-- function getPlayerPosition(cid)
-- 	local player = Creature(cid)
-- 	local pos = player:getPosition()
-- 	return pos
-- end

-- function getTopCreature(pos)
-- 	local tile = Tile(pos)
-- 	local creature = tile:getTopCreature()
-- 	if (creature ~= nil) then
-- 		return {name=creature:getName(), uid=creature:getId()}
-- 	else
-- 		return {name="nobody", uid=-1}
-- 	end
-- end

-- function doSendMagicEffect(pos, effect)
-- 	local position = Position(pos)
-- 	position:sendMagicEffect(effect)
-- end

-- function doPlayerSendCancel(cid, message)
-- 	local player = Player(cid)
-- 	player:sendTextMessage(MESSAGE_STATUS_SMALL, message)
-- end

-- function setPlayerStorageValue(cid, key, value)
-- 	local player = Player(cid)
-- 	player:setStorageValue(key, value)
-- end

-- function getPlayerStorageValue(cid, key)
-- 	local player = Player(cid)
-- 	return player:getStorageValue(key)
-- end

-- function doTeleportThing(cid, pos)
-- 	local creature = Creature(cid)
-- 	local pos = Position(pos)
-- 	creature:teleportTo(pos)
-- end

-- function doCreatureAddHealth(cid, health)
-- 	local creature = Creature(cid)
-- 	creature:addHealth(health)
-- end

--doPlayerSendTextMessage(player.uid, MESSAGE_EVENT_DEFAULT, "You lose.")
-- function doPlayerSendTextMessage(cid, type, message)
-- 	local player = Player(cid)
-- 	player:sendTextMessage(type, message)
-- end

function getThingFromPosition(pos)
	local tile = Tile(pos)
	local thing = tile:getThing(pos.stackpos)
	local info = {itemid=-1, uid=0, count=0}
	if (thing ~= nil) then
		info.itemid = thing:getId()
		info.uid = thing:getUniqueId()
		info.count = thing:getCount()
	end
	return info
end

function getThingFromPos(pos)
	return getThingFromPosition(pos)
end

-- function isPlayer(cid)
-- 	if (Player(cid) ~= nil) then
-- 		return true
-- 	else
-- 		return false
-- 	end
-- end

function getStorage(key)
	return Game.getStorageValue(key) or -1
end

function doSetStorage(key, value)
	Game.setStorageValue(key, value)
	return true
end

function doNumberFormat(i)
	local str, found = string.gsub(i, "(%d)(%d%d%d)$", "%1,%2", 1), 0
	repeat
		str, found = string.gsub(str, "(%d)(%d%d%d),", "%1,%2,", 1)
	until found == 0
	return str
end

-- function doTransformItem(uid, new_id)
-- 	local item = Item(uid)
-- 	item:transform(new_id)

-- end

-- function doRemoveItem(uid, count)
-- 	local item = Item(uid)
-- 	item:remove(count)
-- end

-- function getCreatureName(cid)
-- 	local creature = Creature(cid)
-- 	if (creature ~= nil) then
-- 		return creature:getName()
-- 	else
-- 		return nil
-- 	end
-- end

-- function getPlayerName(cid)
-- 	local player = Player(cid)
-- 	return player:getName()
-- end

-- function doPlayerPopupFYI(cid, message)
-- 	local player = Player(cid)
-- 	player:popupFYI(message)
-- end

--getItemAttribute(tile.uid, "aid")
function getItemAttribute(uid, attr)
	local item = Item(uid)
	if (attr == "aid") then
		return item:getActionId()
	end
end

function doItemSetAttribute(uid, attr, value)
	local item = Item(uid)
	if (attr == "aid") then
		return item:setActionId(value)
	end
end

--doTileAddItemEx(position, item)
function doTileAddItemEx(pos, item)
	Game.createItem(item, 1, Position(pos))
end

function doCleanTile(pos, moveables)
	local tile = Tile(pos)
	local items = tile:getItems()
	if items then
		for i = 1, #items do
			local itemType = items[i]:getType()
			if (itemType:isMovable()) then
				items[i]:remove()
			elseif (moveables) then
				items[i]:remove()
			end
		end
	end
	return true
end