function shuffleArray(array)
    local arrayCount = #array
    for i = arrayCount, 2, -1 do
        local j = math.random(1, i)
        array[i], array[j] = array[j], array[i]
    end
    return array
end


local function unregister(cid)
	if isPlayer(cid) and getCreatureStorage(cid, 1705) ~= -1 and getTileItemById(getPlayerPosition(cid), 425).itemid ~= 425 then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_WARNING, "Unregistered.")
		setPlayerStorageValue(cid, 1705, -1)
	end
	
end

function onStepOut(cid, item, toPos, itemEx, fromPos)

	if item.itemid == 425 then
		doTransformItem(item.uid,426)
	end
	-- if item.itemid == 425 then
		-- addEvent(unregister, 1000, cid)
		-- doTransformItem(item.uid,426)
	-- end
end

local function countPlayers()
	local start = {x=2302,y=2201,z=6}
	local current = {x=2302,y=2201,z=6,stackpos=255}
	local count = 0
	for x=0,4 do
		for y=0,1 do
			current.x = start.x + x
			current.y = start.y + y
			local thing = getThingFromPosition(current).uid
			if isPlayer(thing) then
				count = count + 1
			end
		end
	end
	return count

end

local function startGame()
	local start = {x=2302,y=2201}
	local current = {x=2302,y=2201,z=6,stackpos=255}
	
	local count = 0
	local players = {}
	for x=0,4 do
		for y=0,1 do
			current.x = start.x + x
			current.y = start.y + y
			local thing = getThingFromPosition(current).uid
			if isPlayer(thing) then
				table.insert(players,thing)
			end
		end
	end
	
	players = shuffleArray(players)
	local start = {x=2303,y=2204}
	local current = {x=2303,y=2204,z=6,stackpos=255}
	for x=0,2 do
		for y=0,2 do
			count = count + 1
			current.x = start.x + x
			current.y = start.y + y
			if isPlayer(players[count]) then
				doTeleportThing(players[count], current)
				doSendMagicEffect(current, 13)
				setPlayerStorageValue(players[count], 1705, -1)
			end
		end
	end
	

end

function onStepIn(cid, item, position, fromPos)
	if item.itemid== 426 then
		doPlayerSendTextMessage(cid, MESSAGE_LOOT, "Please place your bet to register to this event.")
		doTransformItem(item.uid,425)
	elseif item.itemid == 419 then
		doTeleportThing(cid, fromPos, false)
	end
	-- elseif item.itemid == 426 then
		-- if getCreatureStorage(cid, 1705) == -1 then
			-- doPlayerSendTextMessage(cid, MESSAGE_LOOT, "You, " .. getCreatureName(cid) .. ", have been registered to this event.")
			-- doSendMagicEffect(toPos, 12)
			-- setPlayerStorageValue(cid, 1705, 1)
			-- doTransformItem(item.uid,425)
			-- if countPlayers() == 1 then
				-- startGame()
			-- end
		-- else
			-- doTransformItem(item.uid,425)
		-- end
	-- end
	return true
end