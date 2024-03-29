local config = {
	[4646] = {Storage.GravediggerOfDrefia.Mission38, Storage.GravediggerOfDrefia.Mission38a},
	[4647] = {Storage.GravediggerOfDrefia.Mission38a, Storage.GravediggerOfDrefia.Mission38b},
	[4648] = {Storage.GravediggerOfDrefia.Mission38b, Storage.GravediggerOfDrefia.Mission38c},
	[4649] = {Storage.GravediggerOfDrefia.Mission38c, Storage.GravediggerOfDrefia.Mission39}
}

function onUse(cid, item, fromPosition, itemEx, toPosition)
	local cStorages = config[itemEx.actionid]
	if not cStorages then
		return true
	end

	local player = Player(cid)
	if player:getStorageValue(cStorages[1]) == 1 and player:getStorageValue(cStorages[2]) < 1 then
		player:setStorageValue(cStorages[2], 1)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, '<sizzle> <fizz>')
		player:getPosition():sendMagicEffect(CONST_ME_ENERGYHIT)
	end
	return true
end