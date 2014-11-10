function onStepIn(cid, item, toPos, itemEx, fromPos)
	local dst = {
		x = getPlayerStorageValue(cid, 1),
		y = getPlayerStorageValue(cid, 2),
		z = getPlayerStorageValue(cid, 3)
	}
	--doRemoveItem(item.uid,1)
	doSendMagicEffect(getPlayerPosition(cid), 2)
	doTeleportThing(cid, dst)
	doSendMagicEffect(getPlayerPosition(cid), CONST_ME_MAGIC_BLUE)
	setPlayerStorageValue(cid, 1, -1)
	setPlayerStorageValue(cid, 2, -1)
	setPlayerStorageValue(cid, 3, -1)
	return true
end