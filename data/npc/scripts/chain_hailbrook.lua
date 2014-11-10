local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}
function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

local msgs = {
	sigmodon = "The Sigmodons are becoming a problem, would you be able to help me kill 5 Sigmodons to reduce their population?",
	sigmodon_a = "Alright adventurer, make sure you also bring me back 5 corpses as proof!",
	urine = "We are in need of Siclee urine for making slime evaporating potions. The Siclees are a unique strain, making them produce a special type of urine.\nWill you collect 15 bottles of Siclee urine for me?",
	urine_a = "Great! Siclees can be found west of the city, underground, and south of the Dheisters. Bring me back urine!",
	lead = "There has been a lot of lead waste going into our sewers, and monsterious creatures arising. May you do a bit of cleanup for me?",
	lead_a = "Here take these potions you helped me conjure, to assist you in defeating the lead monsters. The entrance the the sewers is in an abandoned granary just south of here."
}

local storage = 16900
local accept_flag = 16901


local function completeCheck(cid, value)
	if (value <= 0) then
		if (getPlayerStorageValue(cid, 17000) < 5) then
			selfSay("You havn't killed at least 5 Sigmodons! I cannot give you your reward yet.", cid)
		elseif (getPlayerItemCount(cid, 2813) < 5) then
			selfSay("You need to collect at least 5 Sigmodons! I cannot give you your reward yet.", cid)
		else
			if (doPlayerRemoveItem(cid, 2813, 5) == true) then
				selfSay("Thank you, thank you, thank you. You saved me a lot of trouble. Here is your reward.", cid)
				local item = doCreateItemEx(2653, 1)
				doItemSetAttribute(item, "armor", 5)
				doPlayerAddItemEx(cid, item, true)
				setPlayerStorageValue(cid, storage, 1)
				setPlayerStorageValue(cid, 15913, 2)
				setPlayerStorageValue(cid, accept_flag, 0)
			end
		end
	elseif (value == 1) then
		if (getPlayerItemCount(cid, 5885) < 15) then
			selfSay("Ill be needing 15 bottles, I am sorry I cannot accept anything less.", cid)
		else
			if (doPlayerRemoveItem(cid, 5885, 15)) then
				local item = doCreateItemEx(2120, 1)
				doItemSetAttribute(item, "name", "hook rope")
				doItemSetAttribute(item, "description", "Just a rope you say? No, this rope will let you swing to specific trees.")
				doItemSetAttribute(item, "aid", 2044)
				doPlayerAddItemEx(cid, item, true)
				selfSay("Thank you young one, I am now able to conjure potions! Here, please take this as reward.", cid)
				setPlayerStorageValue(cid, storage, 2)
				setPlayerStorageValue(cid, 15914, 2)
				setPlayerStorageValue(cid, accept_flag, 0)
			end
		end
	elseif (value == 2) then
		if (getPlayerStorageValue(cid, 17001) < 10) then
			selfSay("You havn't killed at least 10 Lead Wastes! I cannot give you your reward yet.", cid)
		else
			local iten = doCreateItemEx(2088,1)
			selfSay("Way to go Adventurer! Heres a silver key for your help. It will allow you to proceed deeper into the sewers.", cid)
			doItemSetAttribute(iten, "aid", 3000)
			doPlayerAddItemEx(cid, iten)
			setPlayerStorageValue(cid, storage, 3)
			setPlayerStorageValue(cid, 15915, 2)
			setPlayerStorageValue(cid, accept_flag, 0)
		end
	elseif (value == 3) then
		if (getPlayerItemCount(cid, 10557) < 6) then
			selfSay("Ill be needing 6 poisonous slimes, I am sorry I cannot accept anything less.", cid)
		else
			if (doPlayerRemoveItem(cid, 10557, 6)) then
				selfSay("Thank you young one, I am now able to conjure arrows! Here, please take this as reward.", cid)
				doPlayerAddItem(cid, 13220)
				setPlayerStorageValue(cid, storage, 4)
				setPlayerStorageValue(cid, 15916, 2)
				setPlayerStorageValue(cid, accept_flag, 0)
			end
		end

	end
end




function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end
	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
	local value = getPlayerStorageValue(cid, storage)
	local accepted = getPlayerStorageValue(cid, accept_flag)
	
	if (msgcontains(msg, 'quest')) then		
		if (accepted ~= 1) then
			if (value <= 0) then
				selfSay(msgs.sigmodon, cid)
				talkState[talkUser] = 1
			elseif (value == 1) then
				selfSay(msgs.urine, cid)
				talkState[talkUser] = 1
			elseif (value == 2) then
				selfSay(msgs.lead, cid)
				talkState[talkUser] = 1
			elseif (value == 3) then
				selfSay("I am trying to craft a bunch of poisonous arrows, but I ran out of poison! Will you gather some more poison for me?", cid)
				talkState[talkUser] = 1
			else
				selfSay("I have nothing more for you currently. Perhaps level up, and speak with me again.", cid)
				talkState[talkUser] = 0
			end
		else
			completeCheck(cid, value)
			talkState[talkUser] = 0
		end
	elseif (msgcontains(msg, 'yes')) and (talkState[talkUser] == 1) then
		if (value <= 0) then
			selfSay(msgs.sigmodon_a, cid)
			setPlayerStorageValue(cid, 15913, 1)
			setPlayerStorageValue(cid, 17000, 0)
		elseif (value == 1) then
			selfSay(msgs.urine_a, cid)
			setPlayerStorageValue(cid, 15914, 1)
		elseif (value == 2) then
			selfSay(msgs.lead_a, cid)
			setPlayerStorageValue(cid, 15915, 1)
			setPlayerStorageValue(cid, 17001, 0)
		elseif (value == 3) then
			selfSay("Great, I need 6 poisonous slimes. Infestors drop it, they can be found past the locked door in the sewers.", cid)
			setPlayerStorageValue(cid, 15916, 1)
		end
		setPlayerStorageValue(cid, accept_flag, 1)
		talkState[talkUser] = 0
	end
end
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())