local gain = {
	gainArmor='&p+1',
	gainShield='&s+1',
	gainAttack='&a+1',
	gainDefense='&d+1',
	blocked_ids = {8881}
}

if not setItemName then
	function setItemName(uid,name)
		return doItemSetAttribute(uid,'name',name)
	end
	function setItemArmor(uid,name)
		return doItemSetAttribute(uid,'armor',name)
	end
	function setItemDefense(uid,name)
		return doItemSetAttribute(uid,'defense',name)
	end
	function setItemAttack(uid,name)
		return doItemSetAttribute(uid,'attack',name)
	end
	function getItemAttack(uid)
		return getItemAttribute(uid,'attack')
	end
	function getItemDefense(uid)
		return getItemAttribute(uid,'defense')
	end
	function getItemArmor(uid)
	   if type(uid) == 'number' then
		  return getItemAttribute(uid,'armor')
	   else
		  return getItemInfo(uid.itemid).armor
	   end
	end
end

function getWeaponLevel(uid) -- Function by Mock the bear.
   uid = uid or 0
   local name = getItemName(uid.uid) or getItemInfo(uid.itemid).name or ''
   local lvl = string.match(name,'%s%+(%d+)%s*')
   return tonumber(lvl) or 0
end
function doTransform(s,i) -- Function by Mock the bear.
    local c = string.gsub(s,'@',0)
    local c = string.gsub(c,'&a',(getItemAttack(i.uid) ~= 0 and getItemAttack(i.uid) or getItemInfo(i.itemid).attack))
    local c = string.gsub(c,'&d',(getItemDefense(i.uid) ~= 0 and getItemDefense(i.uid) or getItemInfo(i.itemid).defense))
    local c = string.gsub(c,'&s',(getItemDefense(i.uid) ~= 0 and getItemDefense(i.uid) or getItemInfo(i.itemid).defense))
    local c = string.gsub(c,'&p',(getItemArmor(i.uid) ~= 0 and getItemArmor(i.uid) or getItemInfo(i.itemid).armor))
    local c = string.gsub(c,'#',getWeaponLevel(i))
    local q = assert(loadstring('return '..c))
    return math.floor(assert(q()))
end

function onUse(cid, item, frompos, item2, topos) 
	if not isPlayer(item2.uid) then
		if (item2.itemid > 0) and ((getItemWeaponType(item2.uid) >= 1 and getItemWeaponType(item2.uid) <= 5) or (isArmor(item2)) or (isWand(item2.uid))) then
			local level = getWeaponLevel(item2)
			local cost_upgrade = cost(item2, level)
			if getPlayerMoney(cid) >= cost_upgrade then
				if doPlayerRemoveMoney(cid, cost_upgrade) then
					doSendMagicEffect(getPlayerPosition(cid), 12)
					local nm = getItemName(item2.uid)
					local slot = nm:match('(%[.+%])') or ''
					slot = slot~='' and ' '..slot or slot
					level = level + 1
					setItemName(item2.uid, getItemNameById(item2.itemid)..' +'..(level)..slot)
					if isArmor(item2) then
						local get = doTransform(gain.gainArmor,item2)
						setItemArmor(item2.uid,get)
					elseif isBow(item2.uid) or isWand(item2.uid) then
						setItemAttack(item2.uid, doTransform(gain.gainAttack,item2))
					elseif isWeapon(item2.uid) then
						setItemAttack(item2.uid, doTransform(gain.gainAttack,item2))
						setItemDefense(item2.uid, doTransform(gain.gainDefense,item2))
					elseif isShield(item2.uid) then
						setItemDefense(item2.uid, doTransform(gain.gainShield,item2))
					end
					local cost_upgrade = cost(item2, level)
					doItemSetAttribute(item2.uid, "description", "Cost to upgrade: "..cost_upgrade.." gp")
				end
			else
				doSendMagicEffect(getPlayerPosition(cid), 2)
				if cost_upgrade ~= false then
					doPlayerSendCancel(cid, "You require " .. (cost_upgrade - getPlayerMoney(cid)) .. " more gold.");
				end
			end
		else
			doPlayerSendCancel(cid, "This: " .. getItemWeaponType(item2.uid) .. " not valid.");
		end
	else
		doSendMagicEffect(getPlayerPosition(cid), 2)
		return false
	end
	return true
end