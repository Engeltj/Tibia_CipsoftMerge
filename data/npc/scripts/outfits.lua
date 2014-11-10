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

	if(msgcontains(msg, 'outfit')) then
		selfSay('Outfit #1 for 5 white', cid)
		selfSay('Outfit #2 for 5 white 2 yellow', cid)
		selfSay('Outfit #3 for 1 yellow 3 brown', cid)
		selfSay('Outfit #5 for 2 yellow 5 brown', cid)
		selfSay('Outfit #5 for 8 brown', cid)
		talkState[talkUser] = 0
	end
	
end

npcHandler:addModule(FocusModule:new())
