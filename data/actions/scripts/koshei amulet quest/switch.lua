local config = {
	{position = Position(33281, 32442, 8), itemId = 3698},
	{position = Position(33286, 32444, 8), itemId = 3698},
	{position = Position(33276, 32444, 8), itemId = 3697},
	{position = Position(33278, 32450, 8), itemId = 3697},
	{position = Position(33284, 32450, 8), itemId = 3697}
}

local coffinPosition = Position(33273, 32452, 8)

local function revertCoffin()
	local coffinItem = Tile(coffinPosition):getItemById(7525)
	if coffinItem then
		coffinItem:transform(7520)
	end
end

function onUse(cid, item, fromPosition, itemEx, toPosition)
	local statuesInOrder, statueItem = true
	for i = 1, #config do
		local statue = config[i]
		statueItem = Tile(statue.position):getItemById(statue.itemId)
		if not statueItem then
			statuesInOrder = false
			break
		end
	end

	if not statuesInOrder or Tile(coffinPosition):getItemById(7525) then
		Player(cid):say('Nothing happens', TALKTYPE_MONSTER_SAY, false, cid, toPosition)
		return true
	end

	local coffinItem = Tile(coffinPosition):getItemById(7520)
	if coffinItem then
		coffinItem:transform(7525)
		addEvent(revertCoffin, 2 * 60 * 1000)
		Player(cid):say('CLICK', TALKTYPE_MONSTER_SAY, false, cid, coffinPosition)
	end
	return true
end
