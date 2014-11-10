local function transformBack(pos)
	local new = getTileItemById(pos, 5120)
	doTransformItem(new.uid, 5119)
end


function onUse(cid, item, fromPos, itemEx, toPos)
	if (item.itemid == 2088) then
		if (itemEx.itemid == 5119) and (itemEx.actionid == 3000) then
			local pos = getThingPos(itemEx.uid)
			doTransformItem(itemEx.uid, (itemEx.itemid + 1))
			addEvent(transformBack,2000, pos)
		end
	end
	return true
end