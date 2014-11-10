local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}
function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end
	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
	if (msgcontains(msg, 'flower')) then
		selfSay("How many flowers would you like to buy? They cost 120 gp each.", cid)
		talkState[talkUser] = 2
	elseif (msgcontains(msg, 'quest')) then	
		local storage = getPlayerStorageValue(cid, 15907)
		if (storage == -1) then
			selfSay("Will you put flowers on graves for me? I have a bad leg and cannot make it to the graves.", cid)
			talkState[talkUser] = 1
		elseif (storage == 1) then
			local s1 = getPlayerStorageValue(cid, 16012)
			local s2 = getPlayerStorageValue(cid, 16013)
			local s3 = getPlayerStorageValue(cid, 16014)
			if (s1==1 and s2==1 and s3==1) then
				selfSay("Thank you so much! Here is a reward for your troubles.", cid)
				local item = doCreateItemEx(2468, 1)
				local level = getPlayerLevel(cid)
				if (level < 70) then
					level = 70
				elseif (level > 85) then
					level = 85
				end
				setItemDefense(item, level)
				doPlayerAddItemEx(cid, item)
				talkState[talkUser] = 0
				setPlayerStorageValue(cid, 15907, 3)
			else
				selfSay("Please put flowers on all 3 graves for me, then we will speak.", cid)
				talkState[talkUser] = 0
			end			
		elseif (storage == 3) then
			selfSay("Thanks " .. getPlayerName(cid) .. ", but I no longer need your help.", cid)
			talkState[talkUser] = 0
		end
	elseif (talkState[talkUser] == 2) then
		local flowers = tonumber(msg)
		if (flowers < 1) then
			selfSay("Too bad then.", cid)
			talkState[talkUser] = 0
		else
			local cost = flowers * 130
			if (doPlayerRemoveMoney(cid, cost)) then
				for x = 1,flowers do
					doPlayerAddItem(cid, 7733, 1)
				end
				if (flowers > 1) then
					selfSay("Here you are! " .. flowers .. " flowers delivered on time.", cid)
				else
					selfSay("Here you are! " .. flowers .. " flower delivered on time.", cid)
				end
			else
				selfSay("No enough money, I cannot sell you these.", cid)
				talkState[talkUser] = 0
			end
		end
	elseif (msgcontains(msg, 'yes')) and (talkState[talkUser] == 1) then	
		selfSay("Thank you young one, please return to me after these flowers have been placed.", cid)
		doPlayerAddItem(cid, 7733, 3)
		setPlayerStorageValue(cid, 15907, 1)
		registerCreatureEvent(cid, "Gravedigger")
		talkState[talkUser] = 0
	elseif (msgcontains(msg, 'no')) and (talkState[talkUser] == 1) then	
		selfSay("Too bad then.", cid)
		talkState[talkUser] = 0
	end
end
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())