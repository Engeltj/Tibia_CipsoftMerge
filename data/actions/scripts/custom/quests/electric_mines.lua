function onUse(cid, item, frompos, itemEx, topos)
	local item1 = 4864 --ectoplasm container
	local item2 = 7281 --resonance crystal
	local pos = getPlayerPosition(cid)
	if item.actionid == 2046 then
		if exhaust(cid, 15013, 24*60*60) then
			local iten = doCreateItemEx(item1)
			doItemSetAttribute(iten, "name", "dark matter capsule")
			doItemSetAttribute(iten, "description", "Conjured by "..getPlayerName(cid))
			doPlayerAddItemEx(cid, iten, true)
			doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "You've created a capsule! Be careful, this item can be dangerous.")
		else
			doSendMagicEffect(pos, 2)
		end
	elseif item.actionid == 2047 then
		if exhaust(cid, 15014, 24*60*60) then
			local iten = doCreateItemEx(item2)
			doItemSetAttribute(iten, "name", "activation crystal")
			doItemSetAttribute(iten, "description", "Conjured by ".. getPlayerName(cid))
			doPlayerAddItemEx(cid, iten, true)
			doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "You've created an activator crystal, only a few know its true purpose.")
		else
			doSendMagicEffect(pos, 2)
		end
	end
	return true
end