local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)            npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)        npcHandler:onCreatureDisappear(cid)            end
function onCreatureSay(cid, type, msg)        npcHandler:onCreatureSay(cid, type, msg)        end
function onThink()                npcHandler:onThink()                    end

-- QUEST --
function Task1(cid, message, keywords, parameters, node)
	local stor1 = 15901
    if(not npcHandler:isFocused(cid)) then
        return false
    end
	
    if getPlayerStorageValue(cid,stor1) < 0 then
		npcHandler:say('I will be here when you fix the problem!',cid)
		doPlayerSetStorageValue(cid, stor1, 0)
    elseif getPlayerStorageValue(cid, stor1) == 0 then
		npcHandler:say('The Sicklees are still stealing horses.',cid)
    elseif getPlayerStorageValue(cid, stor1) == 1 then
		npcHandler:say('Thank you, my horses are saved! I must reward you somehow.. Here, use this to tame a horse of mine. It\'s yours.',cid)
		doPlayerAddItem(cid, 13293, 1)
		doPlayerSetStorageValue(cid, stor1, 2)
		doSendMagicEffect(getCreaturePosition(cid), 13)
    elseif getPlayerStorageValue(cid, stor1) == 2 then
		npcHandler:say('You already unlocked the room, thank you!',cid)
    end
end

local node1 = keywordHandler:addKeyword({'quest'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'The Sicklees keep comming our of the sewers at night, and taking my horses. Will you help me?'})
    node1:addChildKeyword({'yes'}, Task1, {})
    node1:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'You might aswell eat my horses yourself.', reset = true})

npcHandler:addModule(FocusModule:new())