function onUse(cid, item, frompos, itemEx, topos)
	if item.itemid == 13293 then
		if isCreature(itemEx.uid) then
			local stringPos = string.find(getCreatureName(itemEx.uid), "Horse") or 0
			if stringPos ~= false and stringPos > 0 then
				doPlayerAddMount(cid, 25)
				doRemoveItem(item.uid, 1)
			end
		end
	end
	return true
end