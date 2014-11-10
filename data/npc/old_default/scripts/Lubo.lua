local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end

local lastSound = 0
function onThink()
	if lastSound < os.time() then
		lastSound = (os.time() + 5)
		if math.random(100) < 25 then
			Npc():say("Stop by and rest a while, tired adventurer! Have a look at my wares!", TALKTYPE_SAY)
		end
	end
	npcHandler:onThink()
end

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	local player = Player(cid)
	if msgcontains(msg, "addon") or msgcontains(msg, "outfit") then
		if player:getStorageValue(Storage.OutfitQuest.CitizenBackpackAddon) < 1 then
			npcHandler:say("Sorry, the backpack I wear is not for sale. It's handmade from rare {minotaur leather}.", cid)
			npcHandler.topic[cid] = 1
		elseif player:getStorageValue(Storage.OutfitQuest.CitizenBackpackAddon) == 2 then
			if player:getStorageValue(Storage.OutfitQuest.CitizenBackpackAddonWaitTimer) < os.time() then
				npcHandler:say("Just in time! Your backpack is finished. Here you go, I hope you like it.", cid)
				player:setStorageValue(Storage.OutfitQuest.CitizenBackpackAddon, 3)
				player:addOutfitAddon(136, 1)
				player:addOutfitAddon(128, 1)
				player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
				npcHandler.topic[cid] = 0
			else
				npcHandler:say("Uh... I didn't expect you to return that early. Sorry, but I'm not finished yet with your backpack. I'm doing the best I can, promised.", cid)
				npcHandler.topic[cid] = 0
			end
		end
	elseif msgcontains(msg, "minotaur leather") then
		if npcHandler.topic[cid] == 1 then
			npcHandler:say("Well, if you really like this backpack, I could make one for you, but minotaur leather is hard to come by these days. Are you willing to put some work into this?", cid)
			npcHandler.topic[cid] = 2
		end
	elseif msgcontains(msg, "backpack") then
		if player:getStorageValue(Storage.OutfitQuest.CitizenBackpackAddon) == 1 then
			npcHandler:say("Ah, right, almost forgot about the backpack! Have you brought me 100 pieces of minotaur leather as requested?", cid)
			npcHandler.topic[cid] = 3
		end
	elseif msgcontains(msg, "yes") then
		if npcHandler.topic[cid] == 2 then
			npcHandler:say("Alright then, if you bring me 100 pieces of fine minotaur leather I will see what I can do for you. You probably have to kill really many minotaurs though... so good luck!", cid)
			npcHandler.topic[cid] = 0
			player:setStorageValue(Storage.OutfitQuest.CitizenBackpackAddon, 1)
			player:setStorageValue(Storage.OutfitQuest.DefaultStart, 1) --this for default start of Outfit and Addon Quests
		elseif npcHandler.topic[cid] == 3 then
			if player:getItemCount(5878) >= 100 then
				npcHandler:say("Great! Alright, I need a while to finish this backpack for you. Come ask me later, okay?", cid)
				player:removeItem(5878, 100)
				player:setStorageValue(Storage.OutfitQuest.CitizenBackpackAddon, 2)
				player:setStorageValue(Storage.OutfitQuest.CitizenBackpackAddonWaitTimer, os.time() + 2 * 60 * 60) -- 2 hour
				npcHandler.topic[cid] = 0
			else
				npcHandler:say("You don't have it...", cid)
			end
		end
	elseif msgcontains(msg, "no") then
		if npcHandler.topic[cid] > 1 then
			npcHandler:say("Then no.", cid)
			npcHandler.topic[cid] = 0
		end
	return true
	end
end

keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I am selling equipment for adventurers. If you need anything, let me know."})
keywordHandler:addKeyword({'dog'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "This is Ruffy my dog, please don't do him any harm."})
keywordHandler:addKeyword({'offer'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I sell torches, fishing rods, worms, ropes, water hoses, backpacks, apples, and maps."})
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I am Lubo, the owner of this shop."})
keywordHandler:addKeyword({'maps'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Oh! I'm sorry, I sold the last one just five minutes ago."})
keywordHandler:addKeyword({'hat'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "My hat? Hanna made this one for me."})
keywordHandler:addKeyword({'finger'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Oh, you sure mean this old story about the mage Dago, who lost two fingers when he conjured a dragon."})
keywordHandler:addKeyword({'pet'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "There are some strange stories about a magicians pet names. Ask Hoggle about it."})

npcHandler:setMessage(MESSAGE_GREET, "Welcome to my adventurer shop, |PLAYERNAME|! What do you need? Ask me for a {trade} to look at my wares.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Good bye, |PLAYERNAME|.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Good bye.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
