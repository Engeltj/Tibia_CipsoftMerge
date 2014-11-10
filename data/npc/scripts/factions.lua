local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid) 			end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid) 		end
function onCreatureSay(cid, type, msg) 		npcHandler:onCreatureSay(cid, type, msg) 	end
function onThink() 							npcHandler:onThink() 						end
function onPlayerEndTrade(cid)				npcHandler:onPlayerEndTrade(cid)			end
function onPlayerCloseChannel(cid)			npcHandler:onPlayerCloseChannel(cid)		end


function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end

	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid



	if(msgcontains(msg, 'faction')) then
		if (getPlayerStorageValue(cid, 15906) == 1) then
			getPlayerLearnedInstantSpell(cid, "Morph I")
			setPlayerStorageValue(cid, 15906, 2)
		elseif (getPlayerStorageValue(cid, 15906) == 2) then
			selfSay('Would you like to change your faction? This is not reversable.', cid)
			talkState[talkUser] = 2
		elseif (getPlayerVocation(cid) == 1) then
			if(getPlayerLevel(cid)) >= 50 then
				selfSay('Which faction would you like to join? The {strong} (monster), {agile} (animal), or the {balanced} (demonic).', cid)
				talkState[talkUser] = 1
			else
				selfSay('Sorry young one, you must be a least level 50 to join.', cid)
				talkState[talkUser] = 0
			end
		end
	elseif ((msgcontains(msg, 'strong') or msgcontains(msg, 'agile') or (msgcontains(msg, 'balanced'))) and talkState[talkUser] == 1) then
		selfSay('To qualify for this faction, you must complete a task. Check you quest log.', cid)
		if (msgcontains(msg, 'strong')) then
			setPlayerStorageValue(cid, 14999, 22)
		elseif (msgcontains(msg, 'agile')) then
			setPlayerStorageValue(cid, 14999, 23)
		elseif (msgcontains(msg, 'balanced')) then
			setPlayerStorageValue(cid, 14999, 24)
		end
		setPlayerStorageValue(cid, 15905, 1)
	elseif (talkState[talkUser] == 2) then
		if (msgcontains(msg, 'yes')) then
			selfSay('Which faction would you like to join? The {strong} (monster), {agile} (animal), or the {balanced} (demonic).', cid)
			talkState[talkUser] = 1
		else
			selfSay('Or not.', cid)
			talkState[talkUser] = 0
		end
	elseif(msgcontains(msg, 'help')) then
		selfSay('There are 3 factions. Each faction requires completion of a quest, and only 1 faction can be active at one time. Factions have their own unique morphing ability.', cid)
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
