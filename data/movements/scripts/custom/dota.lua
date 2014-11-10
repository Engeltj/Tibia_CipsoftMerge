function moveDown(cid, pos)
	if isCreature(cid) then
		local targets = getMonsterTargetList(cid) or 0
		--local temppos = pos
		--temppos.stackpos = 1
		local flag = 0
		if targets ~= 0 then
			for i, target in ipairs(targets) do
				if isPlayer(target) then
					flag = 1
				end
			end
		
			if flag == 0 then
				pos.y = pos.y+1
				doTeleportThing(cid, getClosestFreeTile(cid, pos), true)
			end
			local temp_pos = getCreaturePosition(cid)
			temp_pos.stackpos = 0
			local tile = getTileThingByPos(temp_pos)
			if (move ~= 500) and (tile.actionid ~= 2005) then
				addEvent(moveDown,100,cid,getCreaturePosition(cid))
			end
		end
	end
end

function onStepIn(cid, item, position, lastPosition, fromPosition, toPosition, actor)
	if not isPlayer(cid) and item.actionid == 2004 then
		addEvent(moveDown, 1000, cid, toPosition)
	elseif item.actionid >= 2006 and item.actionid <= 2009 and isPlayer(cid) then
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
		local tier = 0
		local tile_tier = item.actionid - 2005
		for id = 1, 8, 2 do --0 through to the 8th tower, step up 2
			local tower1 = getThingFromPosition(towers[id]) or 0
			local tower2 = getThingFromPosition(towers[id+1]) or 0
			if not ((isCreature(tower1.uid) and (string.find(getCreatureName(tower1.uid), "Tower") ~= nil)) or (isCreature(tower2.uid) and (string.find(getCreatureName(tower2.uid), "Tower") ~= nil))) then --if both adjacent towers are dead
				tier = tier+1
			end
		end
		if tier < tile_tier then
			doTeleportThing(cid, fromPosition, false)
			doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You must kill tier " .. tile_tier .. " towers first!")
			doSendMagicEffect(fromPosition, 12)
		end
	end
end