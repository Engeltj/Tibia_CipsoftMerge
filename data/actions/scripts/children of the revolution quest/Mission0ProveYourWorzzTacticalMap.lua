function onUse(cid, item, fromPosition, itemEx, toPosition)
	local player = Player(cid)
	if player:getStorageValue(Storage.ChildrenoftheRevolution.Questline) == 1 then
		player:setStorageValue(Storage.ChildrenoftheRevolution.Questline, 2)
		player:addItem(11101, 1)
		player:say("A batch of documents has been stashed in the shelf. These might be of interest to Zalamon.", TALKTYPE_MONSTER_SAY)
		toPosition:sendMagicEffect(CONST_ME_POFF)
	end
	return true
end