function onUse(cid, item, fromPos, itemEx, toPos)

	local pos = {x=2917,y=2465,z=15}
	local bug = getTileItemById(pos, 5468)
	if (bug.itemid == 5468) then
		local newPos = {x = 2871, y = 2535, z = 13}
		doRemoveItem(bug.uid, 1)
		doTeleportThing(cid, newPos)
		doSendMagicEffect(newPos, 12)
	
	end
	
	return true
end
