function onUse(cid, item, fromPosition, itemEx, toPosition)
	doPlayerFeed(cid, 500)
	doSendMagicEffect(fromPosition, 12)
	doRemoveItem(item.uid,1)
	return true
end