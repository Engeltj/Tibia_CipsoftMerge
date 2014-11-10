local function sendMessage(cid, message)
	doPlayerSendTextMessage(cid, MESSAGE_EVENT_ORANGE, message)
	doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, message)
end
whatTime = 0

local function s(add)
	whatTime = whatTime + add
	return whatTime
end

local function endTutorial(cid)
	whatTime = 0
	doCreatureSetNoMove(cid, false)
	addEvent(doTeleportThing, s(2000), cid, {x=2258,y=2245,z=6})
	doCreatureSetLookDirection(cid, 2)
	addEvent(sendMessage, s(2000), cid, "This brings us to the end of the tutorial, I wish you luck with your all journeys!")
	addEvent(sendMessage, s(8000), cid, "Feel free to bring any questions you might have to a CM or to anyone else in the community.")
	doPlayerSetGroupId(cid, getPlayerStorageValue(cid, 1701))
end

local function mapShow(cid)
	whatTime = 0
	local locations = {
		["RushVille"] = {x=2492,y=2337,z=7},
		["Infernal Pits"] = {x=2578,y=2382,z=12},
		["Desert"] = {x=2528,y=1997,z=7},
		["The Jungle"] = {x=2382,y=1738,z=7},
		["City Sewers"] = {x=2199,y=2117,z=8}
	}
	addEvent(sendMessage, s(2000), cid, "Here is a quick view of a few different spawns..")
	s(5000)
	for k, v in pairs(locations) do
		addEvent(doTeleportThing, s(2000), cid, v)
		addEvent(sendMessage, s(0), cid, k)
	end
	addEvent(endTutorial, s(2000), cid)
end

local function features(cid)
	whatTime = 0
	addEvent(sendMessage, s(7000), cid, "I'm now going show you some of what we have to offer.")
	addEvent(doTeleportThing, s(5000), cid, {x=2258,y=2245,z=7})
	addEvent(sendMessage, s(2000), cid, "Here, we have the shop. To buy items, simply drag it off the counter.")
	addEvent(sendMessage, s(6000), cid, "Shop is cleaned, and re-stocked once every hour.")
	addEvent(doTeleportThing, s(5000), cid, {x=2244,y=2273,z=6})
	addEvent(sendMessage, s(2000), cid, "Just south of the depot, we have the archery,")
	addEvent(doTeleportThing, s(4000), cid, {x=2437,y=2187,z=6})
	addEvent(sendMessage, s(0), cid, "and just outside of the town you will find a promotional NPC.")
	addEvent(sendMessage, s(8000), cid, "As far as spawns go, they are scattered everywhere around the map.")
	addEvent(sendMessage, s(5000), cid, "This means you will have to travel! BUT there's good news.")
	addEvent(doTeleportThing, s(2000), cid, {x=2309,y=2260,z=6})
	addEvent(sendMessage, s(2000), cid, "This here, is a waypoint. Walk on it to 'unlock' that travel destination.")
	addEvent(doTeleportThing, s(6000), cid, {x=2310,y=2260,z=6})
	addEvent(doTeleportThing, s(500), cid, {x=2311,y=2260,z=6})
	addEvent(sendMessage, s(2000), cid, "Good job! Now you will be able to quick travel here from any other waypoint using '!travel <destination>'.")
	addEvent(mapShow, s(7000), cid)
	
end

local function monsters(cid)
	whatTime = 0
	local pos = {x=2222,y=2195,z=9}
	doCreateMonster("(Level 8) Gnoll", {x=pos.x, y=pos.y-2, z=pos.z})
	addEvent(sendMessage, s(500), cid, "Monsters are all assigned with a level.")
	addEvent(sendMessage, s(3500), cid, "This level represents their strength.")
	addEvent(sendMessage, s(4500), cid, "For example, if you were level 8, this Gnoll would be a fair fight.")
	addEvent(sendMessage, s(6000), cid, "It is always best to battle creatures of lower level to remain alive.")
	addEvent(features, s(500), cid)
end

local function sellRune(cid)
	whatTime = 0
	local pos = {x=2222,y=2195,z=9}
	local function checkKnife()
		local iten = getTileItemById({x=pos.x-1, y=pos.y-1, z=pos.z},2403)
		if (iten.itemid > 0) then
			addEvent(checkKnife,50)
		else
			iten = getTileItemById({x=pos.x, y=pos.y-1, z=pos.z},2306)
			if (iten.itemid > 0) then
				doRemoveItem(iten.uid, 1)
			end
			addEvent(sendMessage, 500, cid, "Awesome! Now a little about monsters.")
			addEvent(monsters, 2500, cid)
		end
	end
	--remove old rune
	local rune = getTileItemById({x=pos.x, y=pos.y-1, z=pos.z},2297)
	doRemoveItem(rune.uid)
	
	addEvent(doCreateItem, s(50), 2306, {x=pos.x, y=pos.y-1, z=pos.z})
	addEvent(sendMessage, s(1000), cid, "Now, this is a sell rune, try using it on the knife.")
	addEvent(checkKnife,s(500))
end

local function upgradeRune(cid)
	local pos = {x=2222,y=2195,z=9}
	local function createKnife()
		local iten = doCreateItem(2403, {x=pos.x-1, y=pos.y-1, z=pos.z})
		doItemSetAttribute(iten, "attack", 0)
		doItemSetAttribute(iten, "defense", 0)
	end
	
	local function checkUpgrade()
		local iten = getTileItemById({x=pos.x-1, y=pos.y-1, z=pos.z},2403)
		if (iten.itemid > 0) then
			if not (getItemAttribute(iten.uid,'attack') > 0) then
				addEvent(checkUpgrade,50)
			else
				addEvent(sendMessage, 500, cid, "Perfect!")
				addEvent(sellRune, 1000, cid)
			end
		end
	end
	
	
	addEvent(doTeleportThing, s(2000), cid, pos)
	addEvent(doSendMagicEffect, s(0), pos, 12)
	
	--setItemAttack(knife.uid, 0)
	
	addEvent(sendMessage, s(1000), cid, "First of all, upgrade runes.")
	addEvent(createKnife, s(100))
	addEvent(doCreateItem, s(100), 2297, {x=pos.x, y=pos.y-1, z=pos.z})
	addEvent(sendMessage, s(3000), cid, "This is an upgrade rune, try using it on the knife.")
	addEvent(checkUpgrade,s(500))

end



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
	if talkState[talkUser] == 1 then
		if msgcontains(msg, 'sword') then
			selfSay("A sword fighter you say? Great! This may be changed later if you so choose.", cid)
			setPlayerStorageValue(cid, 103, 0)
			doPlayerAddItem(cid, 2403, 1)
			doTeleportThing(cid, {x=2258, y=2245,z=6})
			setPlayerStorageValue(cid, 102, 1)
		elseif msgcontains(msg, 'club') then
			selfSay("A club fighter you say? Great! This may be changed later if you so choose.", cid)
			doPlayerAddItem(cid, 2382, 1)
			setPlayerStorageValue(cid, 103, 1)
			doTeleportThing(cid, {x=2258, y=2245,z=6})
			setPlayerStorageValue(cid, 102, 2)
		elseif msgcontains(msg, 'axe') then
			selfSay("An axe fighter you say? Great! This may be changed later if you so choose.", cid)
			doPlayerAddItem(cid, 2388, 1)
			setPlayerStorageValue(cid, 103, 3)
			doTeleportThing(cid, {x=2258, y=2245,z=6})
			setPlayerStorageValue(cid, 102, 3)
		else
			selfSay("Sorry, I dont know which you are referring to; sword, club or axe?", cid)
		end
	elseif getPlayerStorageValue(cid, 102) ~= -1 and msgcontains(msg, 'yes') then
		selfSay("Looks like you've already done the tutorial, so, what would you like as your primary weapon class? sword, club, or axe.", cid)
		talkState[talkUser] = 1
	elseif msgcontains(msg, 'no') then
		selfSay("Ok then, what would you like as your primary weapon class? sword, club, or axe.", cid)
		talkState[talkUser] = 1
	elseif (msgcontains(msg, 'yes')) or (msgcontains(msg, 'tutorial')) then
		mayNotMove(cid, true)
		doCreatureSetStorage(cid, 1701, getPlayerGroupId(cid))
		setPlayerStorageValue(cid, 15903, 0)
		doPlayerSetGroupId(cid, 2)
		selfSay("Great. Try to keep up!", cid)
		s(250)
		upgradeRune(cid)
	end
	
end
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())