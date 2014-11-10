local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}
local _tag = ""

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
	if(msgcontains(msg, 'tag')) and (talkState[talkUser] ~= 2) then
		local name = getPlayerName(cid)
		local _, _, tag = string.find(name, '(%[%w+%])')
		local gid = getPlayerGuildId(cid)
		local rid = getPlayerGuildLevel(cid)
		
		if not (gid > 0) then
			selfSay('You must be in a guild to purchase a tag.', cid)
			talkState[talkUser] = 0
			return true
		end
		
		if (rid == 3) then
			if (tag ~= nil) then
				selfSay('What would you like to change you guild tag to?', cid)
			else
				selfSay('What would you like to set you guild tag to?', cid)
			end
			talkState[talkUser] = 2
			--local result = db.getResult("SELECT `name` FROM `players` WHERE `players`.`name` LIKE '["..newtag.."]%';")
		else
			selfSay('You must be the guild leader to set or change the tag.', cid)
		end
		--talkState[talkUser] = 1
	elseif (talkState[talkUser] == 2) then
		if (string.len(msg) > 5) then
			selfSay('Tag is too long, give me another.', cid)
			return true
		end
		
		local name = getPlayerName(cid)
		local _, _, tag = string.find(name, '(%[%w+%])')
		local newtag = msg
		newtag = string.gsub(newtag, "%[", "")
		newtag = string.gsub(newtag, "%]", "")
		if (tag == nil) then
			selfSay("For 10cc, would you like to set your guild tag to {"..newtag.."}? To change this later, it will cost 25cc.", cid)
		else
			selfSay("For 25cc, would you like to change your guild tag to {"..newtag.."}?", cid)
		end
		_tag = newtag
		talkState[talkUser] = 3
	elseif (talkState[talkUser] == 3) and (msgcontains(msg, 'yes')) then
		local name = getPlayerName(cid)
		local _, _, tag = string.find(name, '(%[%w+%])')
		local cost = 100000
		if tag ~= nil then
			cost = 250000
		end
		if (doPlayerRemoveMoney(cid, cost)) then
			local gid = getPlayerGuildId(cid)
			local name = Player(cid):getName()
			_, _, tag = string.find(name, '(%[%w+%])')
			if (tag == nil) then
				new_name = "[" .. _tag .. "] " .. name
			else
				new_name = string.gsub(name, '(%[%w+%])', "%[".. _tag .."%]", 1)
			end
			Player(cid):remove()
			-- Player(cid):sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your tag has been set. Relog for updated tag.")
			doPlayerChangeName(name, new_name)
			selfSay('Your tag has been updated! You must relog for these changes to apply.', cid)
		else
			selfSay('You do not have enough money! Come again.', cid)
			
		end
		talkState[talkUser] = 0
	elseif (talkState[talkUser] == 3) and (msgcontains(msg, 'no')) then
		talkState[talkUser] = 2
		selfSay('Ok then, tell me the tag you wish to use.', cid)
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
