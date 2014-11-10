--i have no idea if this is how you comment but this is chris file ;-)*/
--cooldown
--effect
--took a bunch of code from temple-stone
--not tested... updated 11:50am 1/2/2013

function onUse(cid, item, fromPosition, itemEx, toPosition)
	local maxMana = getCreatureMaxMana(cid)
	local curMana = getCreatureMana(cid)
	local manaMin = maxMana*0.05
	local manaMax = maxMana*0.25
	local pos = getPlayerPosition(cid)
	local mana = math.random(manaMin, manaMax)
	local exhaust = {
		storage = 109,
		length = 0 -- 1 sec
	}
	if(curMana == maxMana) then
		doSendMagicEffect(pos, 2)
		doCreatureSay(cid, "Monkeys", TALKTYPE_ORANGE_1)
		return false
	end
	-- if (itemEx.uid ~= 0) then
		-- doCreatureSay(cid, "You may only use this on yourself.", TALKTYPE_ORANGE_1)
		-- return true
	-- end
	if((os.time() - getPlayerStorageValue(cid, exhaust.storage)) >= exhaust.length) or (getPlayerStorageValue(cid, exhaust.storage) == 0) then
		doSendMagicEffect(pos, 1) --i am not sure if this is what you ment by effect 
		doCreatureAddMana(cid, mana)
		doRemoveItem(item.uid, 1)
		setPlayerStorageValue(cid, exhaust.storage, os.time())
	else
		local wait = (exhaust.length - (os.time() - getPlayerStorageValue(cid, exhaust.storage)))
		if wait >= 60 then
			doPlayerSendCancel(cid, "You must wait " ..round((wait/60),0).. " minute(s) to use this item.")
		else
			doPlayerSendCancel(cid, "You must wait " ..round(wait,0).. " seconds to use this item.")
		end
	end
	
	return true
end
