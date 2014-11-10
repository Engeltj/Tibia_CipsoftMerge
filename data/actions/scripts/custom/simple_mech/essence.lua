function onUse(cid, item, fromPos, itemEx, toPos)
	local pos = getCreaturePosition(cid)
	local summons = getCreatureSummons(cid)
	if (summons ~= false) and (#summons > 2) then
		doPlayerSendCancel(cid, "You have reached the summon limit.")
		doSendMagicEffect(pos, 2)
	else
		local name = getItemAttribute(item.uid, "name")
		local level = tonumber(string.match(name,"(%d+)"))
		local plevel = getPlayerLevel(cid)
		if (plevel >= level) then
			doSummonMonster(cid, name)
			doRemoveItem(item.uid)
			doSendMagicEffect(pos, 12)
			
			local summons = getCreatureSummons(cid)
			local speed = getCreatureSpeed(cid)
			for i,v in ipairs(summons) do
				doChangeSpeed(v, math.floor(speed/2))			
			end
			if #summons == 1 then
				addEvent(fixOrphanSummon, 5000, cid)
			end
		else
			doPlayerSendCancel(cid, "You need at least level " .. level .. " to use this item.")
			doSendMagicEffect(pos, 2)
		end
	end
	return true
end