local config = {
	{fromPosition = Position(32677, 32089, 8), toPosition = Position(32671, 32071, 8), sacrificePosition = Position(32679, 32089, 8), sacrificeId = 2175, vocationId = 1},
	{fromPosition = Position(32669, 32089, 8), toPosition = Position(32673, 32071, 8), sacrificePosition = Position(32667, 32089, 8), sacrificeId = 2674, vocationId = 2},
	{fromPosition = Position(32673, 32085, 8), toPosition = Position(32670, 32071, 8), sacrificePosition = Position(32673, 32083, 8), sacrificeId = 2455, vocationId = 3},
	{fromPosition = Position(32673, 32093, 8), toPosition = Position(32672, 32071, 8), sacrificePosition = Position(32673, 32094, 8), sacrificeId = 2376, vocationId = 4}
}

function onUse(cid, item, fromPosition, itemEx, toPosition)
	Item(item.uid):transform(item.itemid == 1945 and 1946 or 1945)

	if item.itemid ~= 1945 then
		return true
	end

	local player = Player(cid)
	local position = player:getPosition()

	local players = {}
	for i = 1, #config do
		local creature = Tile(config[i].fromPosition):getTopCreature()
		if not creature or not creature:isPlayer() then
			player:sendCancelMessage('You need one player of each vocation for this quest.')
			position:sendMagicEffect(CONST_ME_POFF)
			return true
		end

		local vocationId = creature:getVocation():getBase():getId()
		if vocationId ~= config[i].vocationId then
			player:sendCancelMessage('You need one player of each vocation for this quest.')
			position:sendMagicEffect(CONST_ME_POFF)
			return true
		end

		local sacrificeItem = Tile(config[i].sacrificePosition):getItemById(config[i].sacrificeId)
		if not sacrificeItem then
			player:sendCancelMessage(creature:getName() .. ' is missing ' .. (creature:getSex() == 0 and 'her' or 'his') .. ' sacrifice on the altar.')
			position:sendMagicEffect(CONST_ME_POFF)
			return true
		end

		table.insert(players, creature)
	end

	for i = 1, #players do
		local sacrificeItem = Tile(config[i].sacrificePosition):getItemById(config[i].sacrificeId)
		if sacrificeItem then
			sacrificeItem:remove()
		end

		players[i]:getPosition():sendMagicEffect(CONST_ME_POFF)
		players[i]:teleportTo(config[i].toPosition)
		config[i].toPosition:sendMagicEffect(CONST_ME_TELEPORT)
	end
	return true
end
