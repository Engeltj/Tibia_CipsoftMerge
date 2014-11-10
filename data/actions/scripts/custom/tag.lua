function onUse(cid, item, frompos, item2, topos)
	if (item.itemid == 1945) or (item.itemid == 1946) then
		local outfit = getCreatureOutfit(cid)
		local arenaPos = {x=2212,y=2281,z=6}
		setPlayerStorageValue(cid, 16006, outfit.lookType)
		setPlayerStorageValue(cid, 16007, outfit.lookHead)
		setPlayerStorageValue(cid, 16008, outfit.lookBody)
		setPlayerStorageValue(cid, 16009, outfit.lookLegs)
		setPlayerStorageValue(cid, 16010, outfit.lookFeet)
		setPlayerStorageValue(cid, 16011, outfit.lookAddons)
		setPlayerStorageValue(cid, 16005, 1)
		--print("STR " .. getPlayerStorageValue(cid, 16005))
		doSetCreatureOutfit(cid, blue)
		doTeleportThing(cid, arenaPos)
		doSendMagicEffect(arenaPos, 12)
		
		--local gameState = getStorage(16005)
		local count = 0
		local players = getPlayersOnline()
		local playing = {}
		local anyoneIt = false
		-- local result = db.getResult("SELECT * FROM `player_storage` WHERE `player_storage`.`key` = 16005 AND CONVERT( `player_storage`.`value`, signed) > 0")
		-- if (result:getID() ~= -1) then
			-- while true do
			
				-- local guid = result:getDataString("player_id")
				-- local ext_cid = getPlayerByGUID(guid)
				-- print (ext_cid)
				-- if (isPlayer(ext_cid)) then
					-- if (result:getDataString("value") == "2") then
						-- anyoneIt = true
					-- end
					-- table.insert(players, ext_cid)
					-- print ("PLAYER: " .. ext_cid)
				-- end
				-- if not(result:next()) then
					-- break
				-- end
			-- end
			-- result:free()
		-- else
			-- print ("No results for tag")
		-- end
		for i,player in ipairs(players) do
			local storage = getPlayerStorageValue(player, 16005)
			if (storage > 0) then
				table.insert(playing, player)
			end
			if (storage == 2) then
				anyoneIt = true
			end
		end
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Welcome to Hailbrook's TAG!!")
		registerCreatureEvent(cid, "Tag")
		--print("STR " .. getPlayerStorageValue(cid, 16005))
		if not anyoneIt then
			local it = math.random(1, #players)
			doSetCreatureOutfit(players[it], red)
			setPlayerStorageValue(players[it], 16005, 2)
		end
	end
	return true
end
