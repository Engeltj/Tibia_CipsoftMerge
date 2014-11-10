function destroyItem(cid, itemEx, toPosition)
	if itemEx.uid <= 65535 or itemEx.actionid > 0 then
		return false
	end
	--chest,crate,barrel...
	if (itemEx.itemid >= 1724 and itemEx.itemid <= 1741) or (itemEx.itemid >= 2581 and itemEx.itemid <= 2588) or itemEx.itemid == 1770 or itemEx.itemid == 2098 or itemEx.itemid == 1774 or itemEx.itemid == 1775 or itemEx.itemid == 2064 or (itemEx.itemid >= 1747 and itemEx.itemid <= 1753) or (itemEx.itemid >= 1714 and itemEx.itemid <= 1717) or (itemEx.itemid >= 1650 and itemEx.itemid <= 1653) or (itemEx.itemid >= 1666 and itemEx.itemid <= 1677) or (itemEx.itemid >= 1614 and itemEx.itemid <= 1616) or (itemEx.itemid >= 3813 and itemEx.itemid <= 3820) or (itemEx.itemid >= 3807 and itemEx.itemid <= 3810) or (itemEx.itemid >= 2080 and itemEx.itemid <= 2085) or (itemEx.itemid >= 2116 and itemEx.itemid <= 2119) or itemEx.itemid == 2094 or itemEx.itemid == 2095 or itemEx.itemid == 1619 or itemEx.itemid == 2602 or itemEx.itemid == 3805 or itemEx.itemid == 3806 then
		if math.random(7) == 1 then
			if itemEx.itemid == 1738 or itemEx.itemid == 1739 or (itemEx.itemid >= 2581 and itemEx.itemid <= 2588) or itemEx.itemid == 1770 or itemEx.itemid == 2098 or itemEx.itemid == 1774 or itemEx.itemid == 1775 or itemEx.itemid == 2064 then
				Game.createItem(2250, 1, toPosition)
			elseif (itemEx.itemid >= 1747 and itemEx.itemid <= 1749) or itemEx.itemid == 1740 then
				Game.createItem(2251, 1, toPosition)
			elseif (itemEx.itemid >= 1714 and itemEx.itemid <= 1717) then
				Game.createItem(2252, 1, toPosition)
			elseif (itemEx.itemid >= 1650 and itemEx.itemid <= 1653) or (itemEx.itemid >= 1666 and itemEx.itemid <= 1677) or (itemEx.itemid >= 1614 and itemEx.itemid <= 1616) or (itemEx.itemid >= 3813 and itemEx.itemid <= 3820) or (itemEx.itemid >= 3807 and itemEx.itemid <= 3810) then
				Game.createItem(2253, 1, toPosition)
			elseif (itemEx.itemid >= 1724 and itemEx.itemid <= 1737) or (itemEx.itemid >= 2080 and itemEx.itemid <= 2085) or (itemEx.itemid >= 2116 and itemEx.itemid <= 2119) or itemEx.itemid == 2094 or itemEx.itemid == 2095 then
				Game.createItem(2254, 1, toPosition)
			elseif (itemEx.itemid >= 1750 and itemEx.itemid <= 1753) or itemEx.itemid == 1619 or itemEx.itemid == 1741 then
				Game.createItem(2255, 1, toPosition)
			elseif itemEx.itemid == 2602 then
				Game.createItem(2257, 1, toPosition)
			elseif itemEx.itemid == 3805 or itemEx.itemid == 3806 then
				Game.createItem(2259, 1, toPosition)
			end
			Item(itemEx.uid):remove(1)
		end
		toPosition:sendMagicEffect(CONST_ME_POFF)
		return true
	end
	--large amphora
	if itemEx.itemid == 4996 then
		if math.random(3) == 1 then
			local targetItem = Item(itemEx.uid)
			targetItem:transform(4997)
			targetItem:decay()
		end
		toPosition:sendMagicEffect(CONST_ME_POFF)
		return true
	end
	--spiderweb
	if itemEx.itemid == 7538 or itemEx.itemid == 7539 then
		if math.random(7) == 1 then
			if itemEx.itemid == 7538 then
				Item(itemEx.uid):transform(7544)
			elseif itemEx.itemid == 7539 then
				Item(itemEx.uid):transform(7545)
			end
			Item(itemEx.uid):decay()
		end
		toPosition:sendMagicEffect(CONST_ME_POFF)
		return true
	end
	--spideregg AgainstTheSpiderCult
	if itemEx.itemid == 7585 then
		local player = Player(cid)
		local storage = player:getStorageValue(Storage.TibiaTales.AgainstTheSpiderCult)
		if storage >= 1 and storage < 5 then
			player:setStorageValue(Storage.TibiaTales.AgainstTheSpiderCult, math.max(1, storage) + 1)
		end
		Game.createMonster("giant spider", Position(33181, 31869, 12))
		Item(itemEx.uid):transform(7586)
		Item(itemEx.uid):decay()
		toPosition:sendMagicEffect(CONST_ME_POFF)
		return true
	end
	--wooden bar
	if itemEx.itemid == 3798 or itemEx.itemid == 3799 then
		if math.random(3) == 1 then
			if itemEx.itemid == 3798 then
				Item(itemEx.uid):transform(3959)
			elseif itemEx.itemid == 3799 then
				Item(itemEx.uid):transform(3958)
			end
			Item(itemEx.uid):decay()
		end
		toPosition:sendMagicEffect(CONST_ME_POFF)
		return true
	end
	return false
end
