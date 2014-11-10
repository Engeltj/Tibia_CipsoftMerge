function onUse(cid, item, frompos, item2, topos)
	local position = getPlayerPosition(cid)
	local destination= {
		{x=2230, y=2205, z=3},
		{x=2230, y=2223, z=3}
	}	
	if (item.itemid >= 5598) and (item.itemid <= 5601) then
		doTeleportThing(cid, destination[1])
		doSendMagicEffect(position, CONST_ME_POFF)
		doSendMagicEffect(destination[1], CONST_ME_POFF)
	elseif (item.itemid >= 5602) and (item.itemid <= 5605) then
		doTeleportThing(cid, destination[2])
		doSendMagicEffect(position, CONST_ME_POFF)
		doSendMagicEffect(destination[2], CONST_ME_POFF)
	end	
	return true
end