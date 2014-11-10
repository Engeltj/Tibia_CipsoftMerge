local registered = {}

local positions = {}

local exitPos = {x=2304,y=2199,z=6,stackpos=255}

local function genPos()
	local start_pos = {x=2303,y=2204,z=6,stackpos=255}
	local end_pos = {x=2305,y=2207,z=6,stackpos=255}
	local position = deepcopy(start_pos)
	positions = {}
	for y=start_pos.y,end_pos.y,1 do
		for x=start_pos.x,end_pos.x,1 do
			position.x = deepcopy(x)
			position.y = deepcopy(y)
			table.insert(positions,deepcopy(position))
		end
	end

end

local function counterPlayers_nofix()
	local count = 0
	for i, pos in ipairs(positions) do
		local player = getThingFromPosition(pos) or 0
		if isPlayer(player.uid) then
			count = count + 1
		end
	end
	return count

end

local function countPlayers()
	local count = 0
	registered = {}
	for i, pos in ipairs(positions) do
		local player = getThingFromPosition(pos) or 0
		if isPlayer(player.uid) then
			table.insert(registered,player.uid)
			count = count + 1
		end
	end
	return count
end

function inTable(tbl, item)
    for key, value in pairs(tbl) do
        if value == item then return key end
    end
    return false
end

local function bombIt(position)
	doSendMagicEffect(position, 36)
	local player = getThingFromPosition(position) or 0
	if isPlayer(player.uid) then
		doTeleportThing(player.uid, exitPos)
		doPlayerSendTextMessage(player.uid, MESSAGE_EVENT_DEFAULT, "You lose.")
		doPlayerSendTextMessage(player.uid, MESSAGE_EXPERIENCE, "You lose", 100, COLOR_RED, position)
		doSendMagicEffect(exitPos, 12)
		setPlayerStorageValue(player.uid, 1705, -1)
		--count = count + 1
	end
end

local function winningPlayer()
	local winnings = tonumber(getPlayerStorageValue(registered[1], 1705)) * 3
	if tonumber(getStorage(1705)) < winnings then
		winnings = tonumber(getStorage(1705))
	end
	doTeleportThing(registered[1], exitPos)
	doSendMagicEffect(exitPos, 12)
	doPlayerSendTextMessage(registered[1], MESSAGE_INFO_DESCR, "Congratulations, you won " .. winnings .. " gp!")
	doPlayerSendTextMessage(registered[1], MESSAGE_EXPERIENCE, "You win!", 100, COLOR_GREEN, exitPos)
	doPlayerAddMoney(registered[1], winnings)
	setPlayerStorageValue(registered[1], 1705, -1)
	doSetStorage(1705,1500)
	registered = {}
end

local function sendWarning(position)
	doSendMagicEffect(position, 7)
end

local function bomb_locations()
	local chosen = {}
	local numPlayers = countPlayers()
	while (#chosen < 9-numPlayers) do
		local choice = math.random(1,#positions-3)
		if inTable(chosen, choice) == false then
			table.insert(chosen, choice)
		end
	end
	for x = 1, #chosen do
		addEvent(sendWarning,0,positions[chosen[x]])
		addEvent(sendWarning,200,positions[chosen[x]])
		addEvent(sendWarning,400,positions[chosen[x]])
		if numPlayers > 1 then
			addEvent(bombIt, 250*numPlayers+1000, deepcopy(positions[chosen[x]]))
		elseif numPlayers == 1 then
			winningPlayer()
			return
		else
			return
		end
	end
	addEvent(bomb_locations, 6000)
end

local function countCash(cid)
	local player_pos = getPlayerPosition(cid)
	local gold_pos = getPlayerPosition(cid)
	local player_money = 0
	gold_pos.y = gold_pos.y + 1
	gold_pos.stackpos = 252
	while gold_pos.stackpos > 0 do		--COUNT CASH LAYED DOWN
		local tmp = getThingFromPos(gold_pos)
		local count = 1
		if tmp.itemid == ITEM_GOLD_COIN then
			count = tmp.count
			player_money = player_money + 1*count
		elseif tmp.itemid == ITEM_PLATINUM_COIN then
			count = tmp.count
			player_money = player_money + 100*count
		elseif tmp.itemid == ITEM_CRYSTAL_COIN then
			count = tmp.count
			player_money = player_money + 10000*count
		elseif tmp.itemid == ITEM_GOLD_INGOT then
			count = tmp.count
			player_money = player_money + 1000000*count
		end
		gold_pos.stackpos = gold_pos.stackpos - 1
	end
	
	local min_bet = math.ceil(tonumber(getStorage(1705)) / 9)
	if min_bet < 1500 then
		min_bet = 1500
	end
	
	local old_bet = tonumber(getPlayerStorageValue(cid,1705))
	if (player_money+old_bet < min_bet) then
		doPlayerSendCancel(cid, "Place "..doNumberFormat(min_bet-player_money).." gp more infront of you to register.")
		doSendMagicEffect(player_pos, CONST_ME_POFF)
		return
	else
		gold_pos.stackpos = 252
		local tmp = getThingFromPosition(gold_pos)
		while gold_pos.stackpos > 0 do
			if tmp.itemid == ITEM_GOLD_COIN or tmp.itemid == ITEM_PLATINUM_COIN or tmp.itemid == ITEM_CRYSTAL_COIN or tmp.itemid == ITEM_GOLD_INGOT then
				doRemoveItem(tmp.uid, tmp.count)
			end
			gold_pos.stackpos = gold_pos.stackpos - 1
			tmp = getThingFromPos(gold_pos)
		end
		if  old_bet > 0 then
			doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You've added " .. doNumberFormat(player_money) .. " gp to your bet, your total bet is " .. doNumberFormat(old_bet + player_money) .. " gp.")
			setPlayerStorageValue(cid, 1705, player_money+old_bet)
		else
			doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You, " .. getCreatureName(cid) .. ", have been registered and bet " .. doNumberFormat(player_money) .. " gp.")
			setPlayerStorageValue(cid, 1705, player_money)
		end
		if not inTable(registered, getThingFromPosition(player_pos).uid) then
			table.insert(registered,getThingFromPosition(player_pos).uid)
		end
		local pot = tonumber(getStorage(1705))
		if pot == -1 then
			pot = 0
		end
		doSetStorage(1705, pot+player_money)
		doSendMagicEffect(player_pos, 12)
	end
end



function onUse(cid, item, frompos, item2, topos)
	local pos = getPlayerPosition(cid)
	if getPlayerStorageValue(cid, 1705) == -1 then
		setPlayerStorageValue(cid, 1705, 0)
	end
	if item.itemid == 8981 then
		doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "The current pot is " .. doNumberFormat(getStorage(1705)) ..  " gp.\nYour current bet is " .. doNumberFormat(getPlayerStorageValue(cid,1705)) .. " gp.")
		doSendMagicEffect(topos, 7)
		return true
	end
	if pos.y < topos.y and pos.x > topos.x then
		genPos()
		if counterPlayers_nofix() > 0 then
			doPlayerSendCancel(cid, "There appears to be a match in progress.")
			doSendMagicEffect(pos, CONST_ME_POFF)
			return true
		elseif tonumber(getStorage(1705)) < 1500 then
			doSetStorage(1705,1500)
		end
		--doSetStorage(1705,1500)
		--setPlayerStorageValue(cid, 1705, -1) -- TEMPORARY
		countCash(cid)
		if (#registered == 2 ) then
			local count = 0
			for x =1, #registered do
				if isPlayer(registered[x]) then
					count = count + 1
				else
					table.remove(registered,x)
				end
			end
			if count == #registered then
				
				local moveto = getClosestFreeTile(cid, {x=2304,y=2205,z=6})
				for x = 1, #registered do
					doTeleportThing(registered[x], moveto)
					doSendMagicEffect(moveto, 13)
				end
				addEvent(bomb_locations, 2000)
			end
		end
	elseif pos.y > topos.y then
		local newPos = {x=2304,y=2207,z=6}
		local playerEx = getTopCreature(newPos)
		if isPlayer(playerEx.uid) then
			doTeleportThing(playerEx.uid, pos)
			doTeleportThing(cid, newPos)
			doSendMagicEffect(newPos, 12)
			doSendMagicEffect(pos, 13)
		else
			doPlayerSendCancel(cid, "No player to swap with.")
			doSendMagicEffect(pos, CONST_ME_POFF)
		end
		return true
	end
	return true
end
