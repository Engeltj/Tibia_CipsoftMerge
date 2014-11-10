function onEquip(cid, item, slot)
	local lh = getPlayerSlotItem(cid, CONST_SLOT_LEFT)
	local rh = getPlayerSlotItem(cid, CONST_SLOT_RIGHT)
	local voc = getPlayerVocation(cid)
	
	local pass_rh = false
	local pass_lh = false
	if rh.itemid > 0 then
		if (isWeapon(rh.uid) or isWand(rh.uid)) and slot ~= CONST_SLOT_RIGHT then
			pass_rh = true
		end
	end
	if lh.itemid > 0 then
		if (isWeapon(lh.uid) or isWand(lh.uid)) and slot ~= CONST_SLOT_LEFT then
			pass_lh = true
		end
	end
	
	
	if pass_lh or pass_rh then
		if voc ~= 17 then
			addEvent(doPlayerSendCancel, 0, cid, "Only ninjas know how to dual wield.")
			return false
		end
	end
	return true
end