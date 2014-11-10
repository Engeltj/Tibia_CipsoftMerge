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

function firstPromotion(cid, vocation)
	if(doPlayerRemoveMoney(cid, 5000)) then
		--doPlayerSetPromotionLevel(cid, getPlayerPromotionLevel(cid) + 1)
		doPlayerSetVocation(cid, vocation)
		doSendMagicEffect(getCreaturePosition(cid), CONST_ME_MAGIC_GREEN)
		return true
	end
	return false
end

function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end

	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid

	if(msgcontains(msg, 'promote')) then
		if (getPlayerVocation(cid) == 1) then
			if(getPlayerLevel(cid)) >= 20 then
				selfSay('What would you like to become? A Brawler(5k), Ranger(5k), Squire(5k), or Shaman(5k)', cid)
				talkState[talkUser] = 1
			else
				selfSay('Sorry, you must be level 20 or higher for promotion.', cid)
				talkState[talkUser] = 0
			end
		end
	elseif(msgcontains(msg, 'brawler') and talkState[talkUser] == 1) then
		if (firstPromotion(cid, 2) == true) then
			selfSay('You have been promoted!', cid)
		else
			selfSay('Sorry, you don\'t have enough gold.', cid)
		end
		talkState[talkUser] = 0
	elseif(msgcontains(msg, 'ranger') and talkState[talkUser] == 1) then
		if (firstPromotion(cid, 3) == true) then
			selfSay('You have been promoted!', cid)
		else
			selfSay('Sorry, you don\'t have enough gold.', cid)
		end
		talkState[talkUser] = 0
	elseif(msgcontains(msg, 'squire') and talkState[talkUser] == 1) then
		if (firstPromotion(cid, 4) == true) then
			selfSay('You have been promoted!', cid)
		else
			selfSay('Sorry, you don\'t have enough gold.', cid)
		end
		talkState[talkUser] = 0
	elseif(msgcontains(msg, 'shaman') and talkState[talkUser] == 1) then
		if (firstPromotion(cid, 5) == true) then
			selfSay('You have been promoted!', cid)
		else
			selfSay('Sorry, you don\'t have enough gold.', cid)
		end
		talkState[talkUser] = 0
	elseif(msgcontains(msg, 'help')) then
		selfSay('There are 3 tiers of promotions. The first tier costs 10k, which include 4 vocations. Second tier costs 100k, which include 8 vocations. Type \'promotion\' to obtain one of these vocations.', cid)
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
