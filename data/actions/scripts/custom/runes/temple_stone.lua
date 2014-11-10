function round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end


function onUse(cid, item, frompos, item2, topos)
	local exhaust = {
	storage = 107,
	length = 60 * 60	--time in seconds
	}
	local old_pos = getPlayerPosition(cid)
	if hasCondition(cid, CONDITION_INFIGHT) == true then
		doSendMagicEffect(old_pos, 2)
		doPlayerSendCancel(cid, "You may not do this while in combat.")
		return true
	end
	if (((os.time() - getPlayerStorageValue(cid, exhaust.storage)) >= exhaust.length) or (getPlayerStorageValue(cid, exhaust.storage) == 0)) and (getPlayerStorageValue(cid, 106) ~= 1) then
		local town = getPlayerMasterPos(cid)
		if(town ~= LUA_NULL) then
			if(doTeleportThing(cid, town)) then
				if(getPlayerFlagValue(cid, PLAYERFLAG_CANNOTBESEEN) == false) then
					local pos = getPlayerPosition(cid)
					doSendMagicEffect(pos, 2)
					setPlayerStorageValue(cid, 103, old_pos.x)
					setPlayerStorageValue(cid, 104, old_pos.y)
					setPlayerStorageValue(cid, 105, old_pos.z)
					setPlayerStorageValue(cid, 106, 1)
					doSendMagicEffect(town, 12)
					doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "~Welcome Home.. To go back, use the stone again~")
					setPlayerStorageValue(cid, exhaust.storage, os.time())
				end
			else
				doPlayerSendCancel(cid, "Temple position is incorrect. Report to a GM.")
			end
		else
			doPlayerSendCancel(cid, "Town does not exist.")
		end
	elseif (getPlayerStorageValue(cid, 106) == 1) then
		local posx = getPlayerStorageValue(cid, 103)
		local posy = getPlayerStorageValue(cid, 104)
		local posz = getPlayerStorageValue(cid, 105)
		local pos = {x = posx, y = posy, z = posz}
		doTeleportThing(cid, pos)
		doSendMagicEffect(pos, 12)
		setPlayerStorageValue(cid, 106, 0)
	else
		local wait = exhaust.length - (os.time() - getPlayerStorageValue(cid, exhaust.storage))
		if wait >= 60 then
			doPlayerSendCancel(cid, "You must wait " ..round((wait/60),0).. " minute(s) to use this item.")
		else
			doPlayerSendCancel(cid, "You must wait " ..round(wait,0).. " seconds to use this item.")
		end
	end
	return true
end