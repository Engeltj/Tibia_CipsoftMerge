function onUse(cid, item, fromPosition, itemEx, toPosition)
	if itemEx.actionid == 100 and itemEx.itemid == 471 then
		local player = Player(cid)
		if player:getStorageValue(Storage.InServiceofYalahar.Questline) == 36 then
			player:removeItem(9737, 1)
			Game.createItem(9738, 1, toPosition)
			toPosition:sendMagicEffect(CONST_ME_CARNIPHILA)
			local monster
			for i = 1, 2 do
				monster = Game.createMonster('Tormented Ghost', player:getPosition())
				if monster then
					monster:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
				end
			end
		end
	end
	return true
end