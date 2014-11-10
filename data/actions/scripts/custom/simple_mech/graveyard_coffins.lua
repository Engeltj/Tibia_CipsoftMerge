function onUse(cid, item, fromPosition, itemEx, toPosition)
	local seconds = 10
	local pos = getPlayerPosition(cid)
	if item.itemid==7520 then
		doTransformItem(item.uid, 7525)
		doSendMagicEffect(fromPosition, 12)
		addEvent(reset, seconds * 1000, toPosition)
	end
	return true
end

function reset(pos)
	local item = getTileItemById(pos, 7525)
	if item.itemid == 7525 then
		doTransformItem(item.uid, 7520)
	end
end
