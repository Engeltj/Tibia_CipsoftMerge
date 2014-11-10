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
	if (msgcontains(msg, 'ooth') or msgcontains(msg, 'yes')) then
		if (doPlayerRemoveMoney(cid, 1000)) then
			local newpos = {x=2236,y=2411,z=7}
			selfSay("Safe travels!", cid)
			doTeleportThing(cid, newpos)
			doSendMagicEffect(newpos, 10)		
		else
			selfSay("Sorry, you need at least 1000gp to travel to Ooth Isles.", cid)
		end
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'no') then
		selfSay("Maybe another time.", cid)
		talkState[talkUser] = 0
	end
end
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())