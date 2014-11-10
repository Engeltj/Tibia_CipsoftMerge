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

	if(msgcontains(msg, 'capture')) then
		local iten = doCreateItemEx(2272,1)
		doPlayerAddItem(cid, 2272)
		selfSay('Here you go, use this on a bountied player with health lower than 30%', cid)
	elseif(msgcontains(msg, 'list')) then
		local result = db.getResult("SELECT * FROM `player_storage` WHERE `player_storage`.`key` = 16004 AND CONVERT( `player_storage`.`value`, signed) > 1 ORDER BY  CONVERT( `player_storage`.`value`, signed) DESC")
		if (result:getID() ~= -1) then
			selfSay('Here\'s the list.', cid)
			while true do
				local guid = result:getDataString("player_id")
				local price = result:getDataString("value")
				local name = getPlayerNameByGUID(guid)
				selfSay(name .. " : " .. price .. " gps", cid)
				if not(result:next()) then
					break
				end
			end
			result:free()
		else
			selfSay('There are currently no bounties.', cid)
		end
		
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
