function onUse(cid, item, fromPos, itemEx, toPos)
	if item.itemid == 1980 then -- skill upgrade (SKILL_FIST, SKILL_CLUB, SKILL_SWORD, SKILL_AXE, SKILL_DISTANCE, SKILL_SHIELD)
		local fist = getPlayerSkillLevel(cid, SKILL_FIST)
		local club = getPlayerSkillLevel(cid, SKILL_CLUB)
		local sword = getPlayerSkillLevel(cid, SKILL_SWORD)
		local axe = getPlayerSkillLevel(cid, SKILL_AXE)
		local distance = getPlayerSkillLevel(cid, SKILL_DISTANCE)
		if fist >= math.max(club, sword, axe, distance) then
			doPlayerAddSkillTry(cid, SKILL_FIST, 1000, true)
		elseif club >= math.max(fist, sword, axe, distance) then
			doPlayerAddSkillTry(cid, SKILL_CLUB, 1000, true)
		elseif sword >= math.max(fist, club, axe, distance) then
			doPlayerAddSkillTry(cid, SKILL_SWORD, 1000, true)
		elseif axe >= math.max(fist, club, sword, distance) then
			doPlayerAddSkillTry(cid, SKILL_AXE, 1000, true)
		elseif distance >= math.max(fist, club, sword, axe) then
			doPlayerAddSkillTry(cid, SKILL_DISTANCE, 1000, true)
		end
		doPlayerAddSkillTry(cid, SKILL_SHIELD, 1000, true)
	elseif item.itemid == 1981 then -- upgrade token (free item upgrade)
		return true
	elseif item.itemid == 1982 then -- unknown
		return true
	elseif item.itemid == 1983 then -- unknown
		return true
	elseif item.itemid == 1984 then --added max mana
		local voc = getPlayerVocation(cid)
		local info = getVocationInfo(id)
		local hp = info.manaGain * 3
		getCreatureMaxMana(cid, getCreatureMaxMana(cid)+hp)
		doRemoveItem(item.uid)
		doSendMagicEffect(getPlayerPosition(cid), 12)
	elseif item.itemid == 1985 then -- unknown
		return true
	elseif item.itemid == 1986 then -- added max hp
		local voc = getPlayerVocation(cid)
		local info = getVocationInfo(id)
		local hp = info.healthGain * 3
		setCreatureMaxHealth(cid, getCreatureMaxHealth(cid)+hp)
		doRemoveItem(item.uid)
		doSendMagicEffect(getPlayerPosition(cid), 12)
	end
	
	return true
end