local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}
function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end


local function quest1(cid, talkState, talkUser)
	local storage = getPlayerStorageValue(cid, 15910)
	if (storage == -1) then
		selfSay("The Vylns are eating all my crops! I need every crop so I can make enough cash to feed my family. Will you fend off the Vylns for me?", cid)
		talkState[talkUser] = 1
	elseif (storage == 1) then
		selfSay("Please kill at least 50 Vylns and then speak with me.", cid)
		talkState[talkUser] = 0
	elseif (storage == 2) then
		selfSay("Thank you so much! Here is a reward for your troubles.", cid)
		local item = doCreateItemEx(2526, 1)
		local level = getPlayerLevel(cid)
		if (level < 20) then
			level = 20
		elseif (level > 40) then
			level = 40
		end
		setItemDefense(item, level)
		doPlayerAddItemEx(cid, item)
		talkState[talkUser] = 0
		setPlayerStorageValue(cid, 15910, 3)	
	elseif (storage == 3) then
		--selfSay("Thanks " .. getPlayerName(cid) .. ", but I no longer need your help.", cid)
		talkState[talkUser] = 69
	end
	return talkState[talkUser]
end

local function quest2(cid, talkState, talkUser)
	talkState[talkUser] = 69
	return talkState[talkUser]
end

local function quest3(cid, talkState, talkUser)
	local function checkVillagers(cid)
		local summons = getCreatureSummons(cid)
		local count = 0
		for i, v in ipairs(summons) do
			if (getCreatureName(v) == "Villager") then
				count = count + 1
				doRemoveCreature(v)
			end
		end
		return count
	end

	local storage = getPlayerStorageValue(cid, 15912)
	if (storage == -1) then
		selfSay("Most of the villagers have been captured! Meaning no labourers. Will you rescue them for me?", cid)
		talkState[talkUser] = 3
	elseif (storage == 1) or (storage == 2) then
		local storage = getPlayerStorageValue(cid, 17003) + checkVillagers(cid)
		setPlayerStorageValue(cid, 17003, storage)
		if (storage >= 3) then
			selfSay("You're amazing! That was a clean rescue, they aren't even scratched. Here take this, you deserve it.", cid)
			talkState[talkUser] = 0
		else
			selfSay("You need to rescue at least " .. 3-storage .. " more villagers.", cid)
			talkState[talkUser] = 0
		end
	else
		talkState[talkUser] = 69
	end
	return talkState[talkUser]
end

function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end
	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
	if (msgcontains(msg, 'quest')) then	
		talkState[talkUser] = quest1(cid, talkState, talkUser)
		if (talkState[talkUser] == 69) then
			talkState[talkUser] = quest2(cid, talkState, talkUser)
		end
		if (talkState[talkUser] == 69) then
			talkState[talkUser] = quest3(cid, talkState, talkUser)
		end
		if (talkState[talkUser] == 69) then
			selfSay("I have nothing for you at the moment, sorry.", cid)
		end
		
	elseif (msgcontains(msg, 'yes')) then
		if (talkState[talkUser] == 1) then
			selfSay("Thank you master, please return to me after the Vylns are dealt with.", cid)
			registerCreatureEvent(cid, "Farmer")
			setPlayerStorageValue(cid, 17002, 0)
			setPlayerStorageValue(cid, 15910, 1)
		elseif (talkState[talkUser] == 3) then
			setPlayerStorageValue(cid, 17003, 0)
			setPlayerStorageValue(cid, 15912, 1)
			selfSay("Thanks, please save at least 3 of them! Get back to me asap.", cid)
		end
		talkState[talkUser] = 0
	elseif (msgcontains(msg, 'no')) and (talkState[talkUser] >= 1) then	
		selfSay("Too bad then.", cid)
		talkState[talkUser] = 0
	end
end
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())