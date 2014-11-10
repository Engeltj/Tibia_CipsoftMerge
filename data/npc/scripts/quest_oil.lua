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

	if(msgcontains(msg, 'quest')) then
			if getPlayerLevel(cid) >= 90 and getPlayerStorageValue(cid,15000) == -1 then
				selfSay('I need the valves closed on a few bursted oil extraction points. Would you be interested in doing this for me?', cid)
				talkState[talkUser] = 1
			elseif getPlayerStorageValue(cid,15000) == 8 then
				selfSay('You have already finished this quest.', cid)
				talkState[talkUser] = 0
			elseif getPlayerStorageValue(cid,15000) == 7 then
				selfSay('Thank you SO much. Here take this little reward, it\'s the least I could do.', cid)
				doPlayerGiveItem(cid, 2148, 3)
				setPlayerStorageValue(cid,15000,8)
				talkState[talkUser] = 0
			elseif getPlayerStorageValue(cid,15000) >= 0 then
				selfSay('It would appear some of the values aren\'t closed. There are 7 oil extractors.', cid)
				talkState[talkUser] = 0
			else
				selfSay('Sorry, you must be level 90 or higher for this quest.', cid)
				talkState[talkUser] = 0
			end
	elseif(msgcontains(msg, 'yes') and talkState[talkUser] == 1) then
		selfSay('Perfect! Report back to me when all the values are closed.', cid)
		setPlayerStorageValue(cid,15000,0)
		talkState[talkUser] = 0
	elseif(msgcontains(msg, 'no') and talkState[talkUser] == 1) then
		selfSay('Maybe another time then.', cid)
		talkState[talkUser] = 0
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
