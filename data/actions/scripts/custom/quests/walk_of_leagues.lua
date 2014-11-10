function onUse(cid, item, fromPosition, itemEx, toPosition)
	if (isContainer(item.uid)) and (getPlayerStorageValue(cid, 16015) == -1) then
		local iten = getContainerItem(item.uid, 0)
		local new = doCreateItemEx(iten.itemid, 1)
		if isWand(iten.uid) or isBow(iten.uid) then
			doItemSetAttribute(new, "attack", 25)
		elseif isWeapon(iten.uid) then
			doItemSetAttribute(new, "attack", 25)
			doItemSetAttribute(new, "defense", 25)
		elseif isShield(iten.uid) then
			doItemSetAttribute(new, "defense", 25)
		end
		if (doPlayerAddItemEx(cid, new, false)) then
			local newpos = {x=2344,y=2261,z=8}
			setPlayerStorageValue(cid, 16015, 1)
			doTeleportThing(cid, newpos)
			doSendMagicEffect(newpos,CONST_ME_TELEPORT)
		else
			doPlayerSendCancel(cid, "Unable to add item to your inventory, free up space or capacity.")
		end
	elseif (getPlayerStorageValue(cid, 16015) ~= -1) then
		doPlayerSendCancel(cid, "The chest is empty.") 
	end
	return true
end