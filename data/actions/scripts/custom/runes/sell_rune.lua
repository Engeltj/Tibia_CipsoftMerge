function onUse(cid, item, frompos, item2, topos) 
	if (item2.itemid > 0) and ((getItemWeaponType(item2.uid) >= 1 and getItemWeaponType(item2.uid) <= 5) or (getItemWeaponType(item2.uid) == 7) or (isArmor(item2))) then
		if (item2.actionid ~= 0) then
			doPlayerSendCancel(cid, "You may not sell this item.")
			doSendMagicEffect(getPlayerPosition(cid), 2)
			return true
		end
		local sell_price = cost(item2, 1)
		local item_id = tonumber(getPlayerStorageValue(cid, 1700)) or -1
		if item_id == item2.itemid then
			doRemoveItem(item2.uid, 1)
			doPlayerAddMoney(cid, sell_price)
			doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You have sold 1x " .. getItemInfo(item2.itemid).name .. " for " .. sell_price .. " gp.")
			doSendMagicEffect(getPlayerPosition(cid), 12)
			setPlayerStorageValue(cid, 1700, -1)
		else
			doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Use again to sell " .. getItemInfo(item2.itemid).name .. " for " .. sell_price .. " gp.")
			setPlayerStorageValue(cid, 1700, item2.itemid)
			addEvent(setPlayerStorageValue, 10*1000, cid, 1700, 0)
		end
		
	else
		doPlayerSendCancel(cid, "Invalid item. Use with weapons, armors, shields.")
		doSendMagicEffect(getPlayerPosition(cid), 2)
	end
	return true
end