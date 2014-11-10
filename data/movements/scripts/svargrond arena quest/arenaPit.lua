local condition = Condition(CONDITION_OUTFIT)
condition:setTicks(120000)
condition:setOutfit({lookType = 111})

function onStepIn(cid, item, position, fromPosition)
	local player = Player(cid)
	if not player then
		return true
	end

	if item.actionid == 25300 then
		player:addCondition(condition)

		player:setStorageValue(Storage.SvargrondArena.Pit, 0)
		player:teleportTo(SvargrondArena.kickPosition)
		player:say('Coward!', TALKTYPE_MONSTER_SAY)
		SvargrondArena.cancelEvents(cid)
		return true
	end

	local pitId = player:getStorageValue(Storage.SvargrondArena.Pit)
	local arenaId = player:getStorageValue(Storage.SvargrondArena.Arena)
	if pitId > 10 then
		SvargrondArena.rewardPosition:sendMagicEffect(arenaId == 1 and CONST_ME_FIREWORK_BLUE or arenaId == 2 and CONST_ME_FIREWORK_YELLOW or CONST_ME_FIREWORK_RED)
		player:teleportTo(SvargrondArena.rewardPosition)
		player:setStorageValue(Storage.SvargrondArena.Pit, 0)
		player:setStorageValue(SvargrondArena.getActionIdByArena(arenaId), 1)
		player:setStorageValue(Storage.SvargrondArena.Arena, player:getStorageValue(Storage.SvargrondArena.Arena) + 1)
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, 'Congratulations! You completed ' .. ARENA[arenaId].name .. ' arena, you should take your reward now.')
		player:say(arenaId == 1 and 'Welcome back, little hero!' or arenaId == 2 and 'Congratulations, brave warrior!' or 'Respect and honour to you, champion!', TALKTYPE_MONSTER_SAY)
		player:setStorageValue(ARENA[arenaId].questLog, 2)
		player:addAchievement(ARENA[arenaId].achievement)
		SvargrondArena.cancelEvents(cid)
		return true
	end

	local occupant = SvargrondArena.getPitOccupant(pitId, player)
	if occupant then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, occupant:getName() .. ' is currently in the next arena pit. Please wait until ' .. (occupant:getSex() == 0 and 's' or '') .. 'he is done fighting.')
		player:teleportTo(fromPosition, true)
		return true
	end

	SvargrondArena.cancelEvents(cid)
	SvargrondArena.resetPit(pitId)
	SvargrondArena.scheduleKickPlayer(cid, pitId)
	Game.createMonster(ARENA[arenaId].creatures[pitId], PITS[pitId].summon, false, true)

	player:teleportTo(PITS[pitId].center)
	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
	player:say('Fight!', TALKTYPE_MONSTER_SAY)
	return true
end