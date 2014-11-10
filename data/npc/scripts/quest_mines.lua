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
			if getPlayerStorageValue(cid,15917) == -1 then
				selfSay('I need some electrified crafting done for me, will you travel to the depths of these mines to craft some items for me?', cid)
				talkState[talkUser] = 1
			elseif getPlayerStorageValue(cid,15917) == 1 then
				if(getPlayerItemCount(cid,4864)>0 and getPlayerItemCount(cid,7281)>0) then
					local flag = true
					local item1 = getPlayerItemById(cid, true, 4864, 1)
					local item2 = getPlayerItemById(cid, true, 7281, 1)
					
					local desc1 = getItemAttribute(item1.uid, 'description')
					local desc2 = getItemAttribute(item2.uid, 'description')
					if (string.find(desc1, getPlayerName(cid)) == nil) or (string.find(desc2, getPlayerName(cid)) == nil) then
						selfSay('It looks like one of the items was not crafted by you, I cannot accept that.', cid)
						
					else
						if (doRemoveItem(item1.uid) and doRemoveItem(item2.uid)) then
							selfSay('I cannot believe you did this! Thank you, thank you, thank you. Heres a little something for your troubles.', cid)
							--REWARD NEED DECIDING, a key? for access to a room maybe?
							setPlayerStorageValue(cid, 15917,2)
							
						else
							print ("Something went wrong quest_mines.lua in NPCs, player: " ..getPlayerName(cid))
						end
					end
					talkState[talkUser] = 0
				else
					selfSay('You need to obtain both items first, report back to me when both are crafted.', cid)
				end
				talkState[talkUser] = 0
			elseif getPlayerStorageValue(cid,15917) == 2 then
				selfSay('It appears I do not have anything else for you at the moment, come back soon.', cid)
				talkState[talkUser] = 0
			end
	elseif(msgcontains(msg, 'yes') and talkState[talkUser] == 1) then
		selfSay('Perfect! There are crafting tables in opposite corners deepest in the mines, use both, obtaining two unique items. Then report back to me!', cid)
		setPlayerStorageValue(cid,15917,1)
		talkState[talkUser] = 0
	elseif(msgcontains(msg, 'no') and talkState[talkUser] == 1) then
		selfSay('Maybe another time then.', cid)
		talkState[talkUser] = 0
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
