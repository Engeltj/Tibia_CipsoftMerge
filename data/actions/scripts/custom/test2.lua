function onUse(cid, item, fromPosition, itemEx, toPosition)
	local i = Item(item.uid)
	i:setAttribute(ITEM_ATTRIBUTE_ARMOR, "hello")
end
