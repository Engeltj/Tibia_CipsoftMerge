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
			Npc():say("Gather around me, young knights! I'm going to teach you some spells!", TALKTYPE_SAY)
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
		if player:getStorageValue(Storage.OutfitQuest.KnightHatAddon) < 1 then
			npcHandler:say("Only the bravest warriors may wear adorned helmets. They are traditionally awarded after having completed a difficult {task} for our guild.", cid)
			npcHandler.topic[cid] = 1
		end
	elseif msgcontains(msg, "task") then
		if npcHandler.topic[cid] == 1 then
			npcHandler:say("You mean, you would like to prove that you deserve to wear such a helmet?", cid)
			npcHandler.topic[cid] = 2
		end
	elseif msgcontains(msg, "fang") or msgcontains(msg, "behemoth") then
		if player:getStorageValue(Storage.OutfitQuest.KnightHatAddon) == 1 then
			npcHandler:say("Have you really managed to fulfil the task and brought me 100 perfect behemoth fangs?", cid)
			npcHandler.topic[cid] = 4
		end
	elseif msgcontains(msg, "helmet") then
		if player:getStorageValue(Storage.OutfitQuest.KnightHatAddon) == 2 then
			npcHandler:say("Did you recover the helmet of Ramsay the Reckless?", cid)
			npcHandler.topic[cid] = 5
		end
	elseif msgcontains(msg, "sweat")  or msgcontains(msg, "flask") then
		if player:getStorageValue(Storage.OutfitQuest.KnightHatAddon) == 3 then
			npcHandler:say("Were you able to get hold of a flask with pure warrior's sweat?", cid)
			npcHandler.topic[cid] = 6
		end
	elseif msgcontains(msg, "steel") then
		if player:getStorageValue(Storage.OutfitQuest.KnightHatAddon) == 4 then
			npcHandler:say("Ah, have you brought the royal steel?", cid)
			npcHandler.topic[cid] = 7
		end
	elseif msgcontains(msg, "yes") then
		if npcHandler.topic[cid] == 2 then
			npcHandler:say({
				"Well then, listen closely. First, you will have to prove that you are a fierce and restless warrior by bringing me 100 perfect behemoth fangs. ...",
				"Secondly, please retrieve a helmet for us which has been lost a long time ago. The famous Ramsay the Reckless wore it when exploring an ape settlement. ...",
				"Third, we need a new flask of warrior's sweat. We've run out of it recently, but we need a small amount for the show battles in our arena. ...",
				"Lastly, I will have our smith refine your helmet if you bring me royal steel, an especially noble metal. ...",
				"Did you understand everything I told you and are willing to handle this task?"
			}, cid)
			npcHandler.topic[cid] = 3
		elseif npcHandler.topic[cid] == 3 then
			npcHandler:say("Alright then. Come back to me once you have collected 100 perfect behemoth fangs.", cid)
			player:setStorageValue(Storage.OutfitQuest.KnightHatAddon, 1)
			player:setStorageValue(Storage.OutfitQuest.DefaultStart, 1) --this for default start of Outfit and Addon Quests
			npcHandler.topic[cid] = 0
		elseif npcHandler.topic[cid] == 4 then
			if player:getItemCount(5893) >= 100 then
				npcHandler:say("I'm deeply impressed, (brave Knight) " .. player:getName() .. ". (Even if you are not a knight, you certainly possess knight qualities.) Now, please retrieve Ramsay's helmet.", cid)
				player:removeItem(5893, 100)
				player:setStorageValue(Storage.OutfitQuest.KnightHatAddon, 2)
				npcHandler.topic[cid] = 0
			end
		elseif npcHandler.topic[cid] == 5 then
			if player:getItemCount(5924) > 0 then
				npcHandler:say("Good work, (brave Knight) " .. player:getName() .. "! Even though it is damaged, it has a lot of sentimental value. Now, please bring me warrior's sweat.", cid)
				player:removeItem(5924, 1)
				player:setStorageValue(Storage.OutfitQuest.KnightHatAddon, 3)
				npcHandler.topic[cid] = 0
			end
		elseif npcHandler.topic[cid] == 6 then
			if player:getItemCount(5885) > 0 then
				npcHandler:say("Now that is a pleasant surprise, (brave Knight) " .. player:getName() .. "! There is only one task left now: Obtain royal steel to have your helmet refined.", cid)
				player:removeItem(5885, 1)
				player:setStorageValue(Storage.OutfitQuest.KnightHatAddon, 4)
				npcHandler.topic[cid] = 0
			end
		elseif npcHandler.topic[cid] == 7 then
			if player:getItemCount(5887) > 0 then
				npcHandler:say("You truly deserve to wear an adorned helmet, (brave Knight) " .. player:getName() .. ". Please talk to Sam and tell him I sent you. I'm sure he will be glad to refine your helmet.", cid)
				player:removeItem(5887, 1)
				player:setStorageValue(Storage.OutfitQuest.KnightHatAddon, 5)
				npcHandler.topic[cid] = 0
			end
		end
	end
	return true
end

keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I am the first knight. I trained some of the greatest heroes of Tibia."})
keywordHandler:addKeyword({'heroes'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Of course, you heard of them. Knights are the best fighters in Tibia."})
keywordHandler:addKeyword({'king'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Hail to our King!"})
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "You are joking, eh? Of course, you know me. I am Gregor, the first knight."})
keywordHandler:addKeyword({'gregor'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "A great name, isn't it?"})
keywordHandler:addKeyword({'tibia'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Beautiful Tibia. And with our help everyone is save."})
keywordHandler:addKeyword({'time'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "It is time to join the Knights!"})
keywordHandler:addKeyword({'knights'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Knights are the warriors of Tibia. Without us, no one would be safe. Every brave and strong man or woman can join us."})
keywordHandler:addKeyword({'bozo'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Some day someone will make something happen to him..."})
keywordHandler:addKeyword({'elane'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "A bow might be a fine weapon for someone not strong enough to wield a REAL weapon."})
keywordHandler:addKeyword({'frodo'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I and my students often share a cask of beer or wine at Frodo's hut."})
keywordHandler:addKeyword({'gorn'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Always concerned with his profit. What a loss! He was adventuring with baxter in the old days."})
keywordHandler:addKeyword({'baxter'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "He was an adventurer once."})
keywordHandler:addKeyword({'lynda'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Before she became a priest she won the Miss Tibia contest three times in a row."})
keywordHandler:addKeyword({'mcronald'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Peaceful farmers."})
keywordHandler:addKeyword({'ferumbras'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "A fine game to hunt. But be careful, he cheats!"})
keywordHandler:addKeyword({'muriel'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Bah, go away with these sorcerer tricks. Only cowards use tricks."})
keywordHandler:addKeyword({'oswald'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "What an idiot."})
keywordHandler:addKeyword({'quentin'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I will never understand this peaceful monks and priests."})
keywordHandler:addKeyword({'sam'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "He has the muscles, but lacks the guts."})
keywordHandler:addKeyword({'tibianus'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Hail to our King!"})

npcHandler:setMessage(MESSAGE_GREET, "Greetings, |PLAYERNAME|. What do you want?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Be careful on your journeys.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Be careful on your journeys.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
