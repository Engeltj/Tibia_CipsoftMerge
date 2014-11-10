local function subtractHp(cid, hp, i)
	if (isPlayer(cid) and i < 20) then
		doCreatureAddHealth(cid, hp*-1, 8, COLOR_GREEN)
		addEvent(subtractHp, 3000, cid, math.random(hp-2,hp+2), i+1)
	end
end


function onUse(cid, item, fromPos, itemEx, toPos)
	local voc = getPlayerVocation(cid)
	local info = getVocationInfo(voc)
	addEvent(subtractHp, 3000, cid, math.ceil(info.healthGainAmount/2), 0)
	doRemoveItem(item.uid, 1)
	doPlayerSendCancel(cid, "You are suffering.")
	return true
end