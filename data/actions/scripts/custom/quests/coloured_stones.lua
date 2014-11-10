
function onUse(cid, item, frompos, item2, topos)
	local player = Player(cid)
	if item.itemid == 1355 then
		player:setStorageValue(1702, 1)
		doSendMagicEffect(frompos, 12)	
	elseif item.itemid == 1353 and tonumber(player:getStorageValue(1702)) == 1 then
		player:setStorageValue(1702, 2)
		doSendMagicEffect(frompos, 12)
	elseif item.itemid == 1354 and tonumber(player:getStorageValue(1702)) == 2 then
		player:setStorageValue(1702, 0)
		doSendMagicEffect(getPlayerPosition(cid), 2)
		doTeleportThing(cid, {x = 2273, y = 2199, z = 8})
		doSendMagicEffect(getPlayerPosition(cid), 12)
	else
		player:setStorageValue(1702, 0)
		doSendMagicEffect(frompos, 2)
	end
	return true
end