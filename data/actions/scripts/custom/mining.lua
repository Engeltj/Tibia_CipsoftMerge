function createArmor(cid, attr, itemType)
	local flag = false
	local protection = 0
	local search = 0
	local item = {}
	local attrMax,attrMin = 0,0
	local attrType = ''
	if itemType == CONST_SLOT_ARMOR then
		item = {2652,2654,2655,2653,6095,2467,2651,2484,2650,2485,7463,8872,2464,2508,8868,8869,2483,8867,2465,7897,2489,2463,7898,2476,3968,7884,7899,8880,2505,8865,2503,8886,8866,8883,8885,8878,8882,2500,2492,8877,8892,2487,2494,2472,8881,8887,8884,8879,2466,8889,2656,8888,9776,8891,8890,2486}
	elseif itemType == CONST_SLOT_LEGS then
		item = {9928,3983,5918,2649,2468,7730,2648,2478,8923,2469,7896,2647,2504,9777,7885,2507,2477,7895,2488,2495,2470,7894}
	elseif itemType == CONST_SLOT_FEET then
		item = {2642,7457,9931,2641,2643,3982,5462,2195,7886,7892,2645,2646,7893,7891}
	end
	attrMax = attr
	attrMin = attr*0.65
	attrType = 'armor'	
	while flag == false do
		protection = protection + 1 
		search = math.random(1,#item)
		if tonumber(getItemInfo(item[search]).armor) < (attr+250) and tonumber(getItemInfo(item[search]).armor) > (attr-250) then --and getItemInfo(search).armor > (attr-216) then
			local createPos = getPlayerPosition(cid)
			createPos.y = createPos.y - 1
			createPos.stackpos = 255
			local reward = doCreateItem(item[search], createPos)
			doItemSetAttribute(reward, attrType, math.random(math.ceil(attrMin), math.ceil(attrMax)))
			doSendMagicEffect(createPos, 12)
			return true
		end
		if protection > 10000 then
			flag = true
		end
	end
	return false
end

function findLegs(attr)

end

function findFeet(attr)

end

function breakPick(pick, chance)
	local picks = {2553,4874,4856,11421}
	
	if pick.itemid == picks[1] and chance > 925 then
		doRemoveItem(pick.uid, 1)
		return true
	elseif pick.itemid == picks[2] and chance > 960 then
		doRemoveItem(pick.uid, 1)
		return true
	elseif pick.itemid == picks[3] and chance > 980 then
		doRemoveItem(pick.uid, 1)
		return true
	elseif pick.itemid == picks[4] and chance > 997 then
		doRemoveItem(pick.uid, 1)
		return true
	end
	return false
		

end

function onUse(cid, item, fromPos, itemEx, toPos)
	local rusty = {armor=9808, legs=9811, feet=9817}
	local player = Player(cid)
	if item.itemid ~= 1945 and item.itemid ~= 1946 then
		if isMovable(itemEx.uid) then
			return false
		end
		local chance = math.random(1000)
		if chance < 50 then
			local chance2 = math.random(1,3)
			if chance2==1 then
				doPlayerAddItem(cid, rusty.armor)
			elseif change2==2 then
				doPlayerAddItem(cid, rusty.legs)
			elseif chance2==3 then
				doPlayerAddItem(cid, rusty.feet)
			end
			doSendMagicEffect(toPos, 2)
		elseif chance < 300 then
			local moneys = math.random(100,600)
			doPlayerAddMoney(cid, moneys)
			doPlayerSendTextMessage(cid, MESSAGE_LOOT, "Found " .. moneys .. " gp.")
			doSendMagicEffect(toPos, 2)
		else
			doSendMagicEffect(toPos, CONST_ME_POFF)
		end
		if breakPick(item, chance) then
			doPlayerSendCancel(cid, "Your pick seems to have shattered.")
		end
		
		return true
	else
		local attributes = {
			{common=25,rare=35,epic=50}, --tier 1
			{common=125,rare=135,epic=150}, --tier 2
			{common=225,rare=235,epic=250} --tier 3
		}
		
		toPos.stackpos = 254
		toPos.y = toPos.y+1
		local tile = Tile(toPos)
		local usr_item = tile:getTopDownItem()
		local chance = math.random(1000)
		local chance2 = math.random(1000)
		local itemType = 0
		if (usr_item ~= nil and usr_item:getId() == rusty.armor) then
			itemType = CONST_SLOT_ARMOR
		elseif (usr_item ~= nil and usr_item:getId() == rusty.legs) then
			itemType = CONST_SLOT_LEGS
		elseif (usr_item ~= nil and usr_item:getId() == rusty.feet) then
			itemType = CONST_SLOT_FEET
		else
			doPlayerSendCancel(cid, "Place item on stone")
			doSendMagicEffect(fromPos, CONST_ME_POFF)
			return true
		end
		
		if chance > 700 then
			local armor = 0
			if chance > 975 then
				armor = createArmor(cid, attributes[1].epic, itemType)
			elseif chance > 875 then
				armor = createArmor(cid, attributes[1].rare, itemType)
			else
				armor = createArmor(cid, attributes[1].common, itemType)
			end
		else
			doPlayerSendCancel(cid, "Nothing came of this garbage.")
			doSendMagicEffect(toPos, CONST_ME_POFF)
		end
		usr_item:remove()
		return true
	end
	return false
end