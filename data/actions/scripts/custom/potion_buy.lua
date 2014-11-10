function onUse(cid, item, fromPosition, itemEx, toPosition)
	local pos = getCreaturePosition(cid)
	if itemEx.uid == 13008 then
		if doPlayerRemoveMoney(cid, 500) then
			local rune = doPlayerAddItem(cid,8704,10)
			doSetItemSpecialDescription(rune, "Powered by " ..getPlayerName(cid).. "")
			doSendMagicEffect(pos, 12)
		else
			doPlayerSendCancel(cid, "You require 500 gps to buy 10 small health potions.")
			doSendMagicEffect(pos,2)
		end
	elseif itemEx.uid == 13009 then
		if doPlayerRemoveMoney(cid, 500) then
			local rune = doPlayerAddItem(cid,7620,10)
			doSetItemSpecialDescription(rune, "Powered by " ..getPlayerName(cid).. "")
			doSendMagicEffect(pos, 12)
		else
			doPlayerSendCancel(cid, "You require 500 gps to buy 10 mana potions.")
			doSendMagicEffect(pos,2)
		end
	elseif itemEx.uid == 13010 then
		local count = getPlayerItemCount(cid, 7636)
		local value = 10
		if count < 1 then
			count = 1
		end
		if doPlayerRemoveItem(cid, 7636, count) then
			local money = doPlayerAddMoney(cid, value*count)
			doSetItemSpecialDescription(money, "Powered by " ..getPlayerName(cid).. "")
			doSendMagicEffect(pos, 12)
		else
			doPlayerSendCancel(cid, "You don't have any empty flasks")
			doSendMagicEffect(pos,2)
		end	
	end
	
	return true
end