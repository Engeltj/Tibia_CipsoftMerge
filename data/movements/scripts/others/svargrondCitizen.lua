function onStepIn(cid, item, position, fromPosition)
	local player = Player(cid)
	if not player then
		return true
	end

	if player:getStorageValue(Storage.BarbarianTest.Mission03) == 3 then
		player:teleportTo(Position(32212, 31131, 5))
	else
		player:teleportTo(Position(32210, 31134, 7))
		player:say('You have to be a honorary barbarian to access the roof. Talk to the Jarl about it.', TALKTYPE_MONSTER_SAY)
	end

	player:setDirection(EAST)
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	return true
end