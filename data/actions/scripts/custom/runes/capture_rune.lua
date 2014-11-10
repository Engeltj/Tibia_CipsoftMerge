local function releaseJail(cid)
	if (isPlayer(cid) and getPlayerStorageValue(cid, 16004) > 1) then
		doTeleportThing(cid, {x=2251,y=2287,z=6})
		doSendMagicEffect({x=2251,y=2287,z=6}, 12)
		doPlayerSendTextMessage(MESSAGE_STATUS_DEFAULT, "You have been released from jail.")
		setPlayerStorageValue(cid, 16004, -1)
	end
end

function onUse(cid, item, fromPos, itemEx, toPos)
	local JAIL_TIME = 5 -- minutes
	if (isPlayer(itemEx.uid)) then
		local storage_target = getPlayerStorageValue(itemEx.uid, 16004)
		--print (storage_target)
		if (storage_target > 1) then
			local hp_percent = getCreatureHealth(itemEx.uid)/getCreatureMaxHealth(itemEx.uid)
			if (hp_percent <= 0.30) then
				local level = getPlayerLevel(target)
				local winnings = getPlayerStorageValue(itemEx.uid, 16004)
				doBroadcastMessage(getPlayerName(itemEx.uid) .. " was captured and the bounty was collected!", MESSAGE_EVENT_DEFAULT)
				doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "You collected " .. doNumberFormat(winnings) .. " gps on this bounty (deposited to bank)")
				doPlayerDepositMoney(cid, winnings)
				doTeleportThing(itemEx.uid, {x=2247,y=2286,z=6})
				doPlayerSendTextMessage(itemEx.uid, MESSAGE_EVENT_ADVANCE, "You have been jailed for 5 minutes!")
				setPlayerStorageValue(itemEx.uid, 16004, -1)
				setPlayerStorageValue(itemEx.uid, 16003, 0)
				addEvent(releaseJail, 60*1000*JAIL_TIME, itemEx.uid)
			else
				doPlayerSendCancel(cid, "Player is not weakened enough, he must have very low health!")
				doSendMagicEffect(getPlayerPosition(cid), 2)
			end
			
		else
			doPlayerSendCancel(cid, "Player is not on the bounty list.")
			doSendMagicEffect(getPlayerPosition(cid), 2)
		end
	else
		doPlayerSendCancel(cid, "You may only use this on bountied players.")
		doSendMagicEffect(getPlayerPosition(cid), 2)
	end
	return true
end