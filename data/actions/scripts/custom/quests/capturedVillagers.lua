local function respawnVillager(pos)
	local item = doCreateItem(13176, pos)
	doItemSetAttribute(item, "aid", 2043)
end

local function checkVillagers(cid)
	local summons = getCreatureSummons(cid)
	local count = 0
	for i, v in ipairs(summons) do
		local name = getCreatureName(v)
		if (name == "Villager") then
			count = count + 1
		end
	end
	return count
end

function onUse(cid, item, frompos, item2, toPos)
	if (getPlayerStorageValue(cid, 15912) == 1) then
		doRemoveItem(item.uid)
		doSummonMonster(cid, "Villager")
		local storage = getPlayerStorageValue(cid, 17003) + checkVillagers(cid)
		local summons = getCreatureSummons(cid) 
		if #summons == 1 then
			fixOrphanSummon(cid)
		end
		addEvent(respawnVillager, 60*1000, toPos)
		if (storage == 3) then
			setPlayerStorageValue(cid, 15912, 2)
		end
	end
	return true
end