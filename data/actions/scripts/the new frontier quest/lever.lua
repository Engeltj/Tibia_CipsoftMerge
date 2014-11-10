local config = {
	[8005] = Position(33055, 31527, 14),
	[8006] = Position(33065, 31489, 15)
}

function onUse(cid, item, fromPosition, itemEx, toPosition)
	local targetPosition = config[item.actionid]
	if not targetPosition then
		return true
	end

	Item(item.uid):transform(item.itemid == 1945 and 1946 or 1945)

	toPosition.x = item.actionid == 8005 and toPosition.x + 1 or toPosition.x - 1
	local creature = Tile(toPosition):getTopCreature()
	if not creature or not creature:isPlayer() then
		return true
	end

	if item.itemid ~= 1945 then
		return true
	end

	if item.actionid == 8005 then
		if creature:getStorageValue(Storage.TheNewFrontier.Mission05) == 7 then
			targetPosition.z = 10
		elseif creature:getStorageValue(Storage.TheNewFrontier.Mission03) == 3 then
			targetPosition.z = 12
		end
	end

	creature:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	creature:teleportTo(targetPosition)
	targetPosition:sendMagicEffect(CONST_ME_TELEPORT)
	return true
end
