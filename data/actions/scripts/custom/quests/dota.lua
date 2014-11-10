local spawnmore = nil
local spawnmore2 = nil

function spawnCreatures(tier, spawns)
	for a, spawn in ipairs(spawns) do
		doSummonCreature(tier, spawn)
		local creature = getThingFromPosition(spawn)
		if isCreature(creature.uid) then
			local move = spawn
			move.y = move.y+1
			doTeleportThing(creature.uid, move, true)
		end
	end
end

function cleanArena(start_pos, end_pos)
	start_pos.stackpos = 255
	end_pos.stackpos = 255
	local position = deepcopy(start_pos)
	for x=start_pos.x,end_pos.x,1 do
		for y=start_pos.y,end_pos.y,1 do
			position.x = deepcopy(x)
			position.y = deepcopy(y)
			local player = getThingFromPosition(position) or 0
			if isCreature(player.uid) then
				doRemoveCreature(player.uid, true)
			end
		end
	end
	
	local chests = {
		getTileItemById({x=2048,y=2057,z=5}, 1740).uid,
		getTileItemById({x=2050,y=2057,z=5}, 1740).uid
	}
	if chests[1] > 0 and isContainer(chests[1]) then
		doRemoveItem(chests[1],1)
	end
	if chests[2] > 0 and isContainer(chests[2]) then
		doRemoveItem(chests[2],1)
	end
	
	if spawnmore ~= nil then
		stopEvent(spawnmore)
		spawnmore = nil
	end
	if spawnmore2 ~= nil then
		stopEvent(spawnmore)
		spawnmore2 = nil
	end
end

--Returns true if player exists in area
--2D function only, top left first to bottom right
function checkForPlayers(start_pos, end_pos) 
	start_pos.stackpos = 255
	end_pos.stackpos = 255
	local position = deepcopy(start_pos)
	for x=start_pos.x,end_pos.x,1 do
		for y=start_pos.y,end_pos.y,1 do
			position.x = deepcopy(x)
			position.y = deepcopy(y)
			local player = getThingFromPosition(position) or 0
			if isPlayer(player.uid) then
				return true
			end
		end
	end
	return false
end


function isArenaEmpty()
	local area = {
		{x=2041,y=2057,z=5}, --start
		{x=2056,y=2069,z=5}, --end
		
		{x=2045,y=2070,z=5}, --start
		{x=2053,y=2128,z=5}  --end
	}
	if not (checkForPlayers(area[1],area[2]) or checkForPlayers(area[3],area[4])) then
		cleanArena(area[1],area[2])
		cleanArena(area[3],area[4])
		return true
	end
	return false
end

function spawnTowers(level, towers, tower_final)	
	for a, tower in ipairs(towers) do
		local pos = tower
		if level == 1 then
			doSummonCreature("Easy Tower", pos)
		elseif level == 2 then
			doSummonCreature("Medium Tower", pos)
		elseif level == 3 then
			doSummonCreature("Hard Tower", pos)
		end
	end
	if level == 1 then
		doSummonCreature("Easy Ancient Tower", tower_final)
	elseif level == 2 then
		doSummonCreature("Medium Ancient Tower", tower_final)
	elseif level == 3 then
		doSummonCreature("Hard Ancient Tower", tower_final)
	end

end

function launchWave(tier_melee, tier_range, level, towers, tower_final, spawns)
	local spawns = {
		{ --First
		{x = 2048,y = 2071,z = 5,stackpos = 253},
		{x = 2049,y = 2071,z = 5,stackpos = 253},
		{x = 2050,y = 2071,z = 5,stackpos = 253}
		},
		{ --After last towers die (before final 3)
		{x = 2048,y = 2063,z = 5,stackpos = 253},
		{x = 2049,y = 2063,z = 5,stackpos = 253},
		{x = 2050,y = 2063,z = 5,stackpos = 253}
		}
	}
	local tier = 1
	local spawn = 1
	for id = 1, 8, 2 do --0 through to the 8th tower, step up 2
		local tower1 = getThingFromPosition(towers[id]) or 0
		local tower2 = getThingFromPosition(towers[id+1]) or 0
		if not ((isCreature(tower1.uid) and (string.find(getCreatureName(tower1.uid), "Tower") ~= nil)) or (isCreature(tower2.uid) and (string.find(getCreatureName(tower2.uid), "Tower") ~= nil))) then --if both adjacent towers are dead
			tier = tier+1
		end
	end
	if (tier >= 5) then --change spawn if all pathway towers are dead. Moves spawn more northern
		spawn = 2
	end
	local win = getThingFromPosition(tower_final) or 0
	if isCreature(win.uid) and (string.find(getCreatureName(win.uid), "Tower") ~= nil) then
		spawnCreatures(tier_melee[level][tier], spawns[spawn]) --spawn melee
		spawnmore = addEvent(spawnCreatures, 2000, tier_range[level][tier], spawns[spawn]) --wait (for clear), then spawn rangers
		spawnmore2 = addEvent(launchWave, 30000, tier_melee, tier_range, level, towers, tower_final) --spawn another wave in 30 seconds
	end
	isArenaEmpty()
end

function onUse(cid, item, fromPosition, itemEx, toPosition)
	local tier_melee = {
		{ --Easy
		"(Tier 1) Lizard Warrior",
		"(Tier 2) Lizard Warrior",
		"(Tier 3) Lizard Warrior",
		"(Tier 4) Lizard Warrior",
		"(Tier 4) Lizard Warrior"
		},
		{ --Medium
		"(Tier 1) Lizard Guardian",
		"(Tier 2) Lizard Guardian",
		"(Tier 3) Lizard Guardian",
		"(Tier 4) Lizard Guardian",
		"(Tier 4) Lizard Guardian"
		},
		{ --Hard
		"(Tier 1) Lizard Legion",
		"(Tier 2) Lizard Legion",
		"(Tier 3) Lizard Legion",
		"(Tier 4) Lizard Legion",
		"(Tier 4) Lizard Legion"
		}
	}
	
	local tier_range = {
		{ --Easy
		"(Tier 1) Lizard Magus",
		"(Tier 2) Lizard Magus",
		"(Tier 3) Lizard Magus",
		"(Tier 4) Lizard Magus"
		},
		{ --Medium
		"(Tier 1) Lizard Necromancer",
		"(Tier 2) Lizard Necromancer",
		"(Tier 3) Lizard Necromancer",
		"(Tier 4) Lizard Necromancer"
		},
		{ --Hard
		"(Tier 1) Lizard Warlock",
		"(Tier 2) Lizard Warlock",
		"(Tier 3) Lizard Warlock",
		"(Tier 4) Lizard Warlock"
		}
	}
	
	local towers = {
		{x = 2047,y = 2121,z = 5,stackpos = 253}, --Tier 1
		{x = 2051,y = 2121,z = 5,stackpos = 253}, 
		{x = 2047,y = 2109,z = 5,stackpos = 253}, --Tier 2 
		{x = 2051,y = 2109,z = 5,stackpos = 253},
		{x = 2047,y = 2097,z = 5,stackpos = 253}, --Tier 3
		{x = 2051,y = 2097,z = 5,stackpos = 253},
		{x = 2047,y = 2082,z = 5,stackpos = 253}, --Tier 4
		{x = 2051,y = 2082,z = 5,stackpos = 253}, 
		
		{x = 2045,y = 2065,z = 5,stackpos = 253}, 
		{x = 2053,y = 2065,z = 5,stackpos = 253},
	}
	
	-- local leverPos = {
		-- {x = 2048,y = 2132,z = 5,stackpos = 253}, --First in line pos
		-- {x = 2049,y = 2132,z = 5,stackpos = 253}, --First in line pos
		-- {x = 2050,y = 2132,z = 5,stackpos = 253}  --First in line pos
	-- }
	local tower_final = {x = 2049,y = 2060,z = 5,stackpos = 253}
	local level = item.actionid - 2010
	local start_pos = {x=2047,y=2128,z=5,stackpos=253}
	local valid_pull = 0
	
	
	--Check and clean
	if not isArenaEmpty() then
		doPlayerSendCancel(cid, "Arena currently in use!")
		return false
	end
	
	local flag = 0
	for x=1,5,1 do --Player check
		local pos = getThingPosition(item.uid)
		local new_pos = start_pos
		pos.y = pos.y + x
		pos.stackpos = 255
		local player = getThingFromPosition(pos) or 0
		if player.uid == cid then
			flag = 1
		end
		if isPlayer(player.uid) and flag == 1 then
			new_pos.x = new_pos.x+x-1
			doTeleportThing(player.uid, new_pos, false)
			doSendMagicEffect(new_pos, 12)
			valid_pull = valid_pull + 1 --Flag also determines # of players
		end
	end
	
	if valid_pull > 0 then
		spawnTowers(level, towers, tower_final)
		launchWave(tier_melee, tier_range, level, towers, tower_final)
	else
		doPlayerSendCancel(cid, "Please stand on the tiles in a line first.")
		return false
	end
	return true
end