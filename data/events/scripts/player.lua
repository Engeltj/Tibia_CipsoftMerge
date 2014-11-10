function Player:onBrowseField(position)
	return true
end

function Player:onLook(thing, position, distance)
	local description = 'You see ' .. thing:getDescription(distance)
	if self:getGroup():getAccess() then
		if thing:isItem() then
			description = string.format('%s\nItemID: [%d]', description, thing:getId())

			local actionId = thing:getActionId()
			if actionId ~= 0 then
				description = string.format('%s, ActionID: [%d]', description, actionId)
			end

			local uniqueId = thing:getAttribute(ITEM_ATTRIBUTE_UNIQUEID)
			if uniqueId > 0 and uniqueId < 65536 then
				description = string.format('%s, UniqueId: [%d]', description, uniqueId)
			end

			description = description .. '.'
			local itemType = thing:getType()

			local transformEquipId = itemType:getTransformEquipId()
			local transformDeEquipId = itemType:getTransformDeEquipId()
			if transformEquipId ~= 0 then
				description = string.format('%s\nTransformTo: [%d] (onEquip).', description, transformEquipId)
			elseif transformDeEquipId ~= 0 then
				description = string.format('%s\nTransformTo: [%d] (onDeEquip).', description, transformDeEquipId)
			end

			local decayId = itemType:getDecayId()
			if decayId ~= -1 then
				description = string.format('%s\nDecayTo: [%d]', description, decayId)
			end
		elseif thing:isCreature() then
			local str = '%s\nHealth: [%d / %d]'
			if thing:getMaxMana() > 0 then
				str = string.format('%s, Mana: [%d / %d]', str, thing:getMana(), thing:getMaxMana())
			end
			description = string.format(str, description, thing:getHealth(), thing:getMaxHealth()) .. '.'
		end

		local position = thing:getPosition()
		description = string.format(
			'%s\nPosition: [X: %d] [Y: %d] [Z: %d].',
			description, position.x, position.y, position.z
		)

		if thing:isCreature() and thing:isPlayer() then
			description = string.format('%s\nIP: [%s].', description, Game.convertIpToString(thing:getIp()))
		end
	end
	self:sendTextMessage(MESSAGE_INFO_DESCR, description)
end

function Player:onLookInBattleList(creature, distance)
	local description = 'You see ' .. creature:getDescription(distance)
	if self:getGroup():getAccess() then
		local str = '%s\nHealth: [%d / %d]'
		if creature:getMaxMana() > 0 then
			str = string.format('%s, Mana: [%d / %d]', str, creature:getMana(), creature:getMaxMana())
		end
		description = string.format(str, description, creature:getHealth(), creature:getMaxHealth()) .. '.'

		local position = creature:getPosition()
		description = string.format(
			'%s\nPosition: [X: %d] [Y: %d] [Z: %d].',
			description, position.x, position.y, position.z
		)

		if creature:isPlayer() then
			description = string.format('%s\nIP: [%s].', description, Game.convertIpToString(creature:getIp()))
		end
	end
	self:sendTextMessage(MESSAGE_INFO_DESCR, description)
end

function Player:onLookInTrade(partner, item, distance)
	self:sendTextMessage(MESSAGE_INFO_DESCR, 'You see ' .. item:getDescription(distance))
end

function Player:onLookInShop(itemType, count)
	return true
end

function Player:onMoveItem(item, count, fromPosition, toPosition)
	local tile = toPosition:getTile()
	if tile then
		local thing = tile:getItemByType(ITEM_TYPE_TELEPORT)
		if thing then
			self:sendCancelMessage('Sorry, not possible.')
			self:getPosition():sendMagicEffect(CONST_ME_POFF)
			return false
		end
	end

	if item:getActionId() == 2031 then
		local price = shop_prices[item:getId()]
		local item_id = self:getStorageValue(1704)
		if item_id == item:getId() then
			if self:removeMoney(price) then
				item:setActionId(0)
				doSendMagicEffect(getPlayerPosition(cid), 12)
				doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You have bought 1x " .. item:getName() .. " for " .. price .. " gp.")
				fromPosition.stackpos = 255
				addEvent(createShopItem, 150, fromPosition, 100)
				return true
			else
				self:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You require " .. doNumberFormat(price - self:getMoney()) .. " more gold.")
				self:sendCancelMessage("You require " .. doNumberFormat(price - self:getMoney()) .. " more gold.")
				self:getPosition():sendMagicEffect(CONST_ME_POFF)
				return false
			end
		else
			self:sendTextMessage(MESSAGE_INFO_DESCR, 'Take the item again to purchase for ' .. doNumberFormat(price) .. " gps.")
			self:setStorageValue(1704, item:getId())
		end
		return false
	end

	if isInArray({1714, 1715, 1716, 1717, 1738, 1740, 1741, 1747, 1748, 1749}, item:getId()) and item:getActionId() > 0 then
		self:sendCancelMessage('You cannot move this object.')
		return false
	elseif item:getId() == 7466 then
		self:sendCancelMessage('You cannot move this object.')
		return false
	end

	if fromPosition.x == 65535 and toPosition.x == 65535
			and item:getId() == 8710 and self:getItemCount(8710) == 2 and self:getStorageValue(Storage.RookgaardTutorialIsland.cockroachLegsMsgStorage) ~= 1 then
		self:sendTextMessage(MESSAGE_INFO_DESCR, 'Well done, you have enough cockroach legs! You should head back to Santiago with them. Climb the ladder to the north to exit.')
		self:setStorageValue(Storage.RookgaardTutorialIsland.cockroachLegsMsgStorage, 1)
		self:setStorageValue(Storage.RookgaardTutorialIsland.SantiagoNpcGreetStorage, 6)
	end
	return true
end

function Player:onMoveCreature(creature, fromPosition, toPosition)
	return true
end

function Player:onTurn(direction)
	return true
end

function Player:onTradeRequest(target, item)
	if isInArray({1738, 1740, 1747, 1748, 1749, 8766}, item:getId()) and item:getActionId() > 0 then
		self:sendCancelMessage('Sorry, not possible.')
		return false
	end
	return true
end

function Player:onTradeAccept(target, item, targetItem)
	return true
end

local config =  {
	[1] = 1.10, -- +10%
	[2] = 1.20, -- +20%
	[3] = 1.50, -- +50%
	[4] = 1.90 -- +90%
}

function Player:onGainExperience(source, exp, rawExp)
	local party = self:getParty()
	if party then
		if party:isSharedExperienceEnabled() and party:isSharedExperienceActive() then
			local bonus = config[party:getVocationCount()]
			if not bonus then
				return exp
			end

			exp = exp * bonus
		end
	end

	return exp
end

function Player:onLoseExperience(exp)
	return exp
end
