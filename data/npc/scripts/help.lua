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

	if(msgcontains(msg, 'help')) then
		selfSay('Choose a topic: {vocations}, {games}, {leveling}, {factions}, {guild tags}, {gold}', cid)
		talkState[talkUser] = 1
		
	elseif(msgcontains(msg, 'vocations')) then
	
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
