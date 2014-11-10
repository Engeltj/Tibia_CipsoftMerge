local wandAnim ={
	[8910] = CONST_ANI_DEATH,
	[8911] = CONST_ANI_ICE,
	[8912] = CONST_ANI_SMALLEARTH,
	[8920] = CONST_ANI_ENERGY,
	[8921] = CONST_ANI_FIRE,
	[8922] = CONST_ANI_DEATH,
	[13760] = CONST_ANI_DEATH,
	[13872] = CONST_ANI_SMALLICE,
	[13880] = CONST_ANI_ENERGY,
	[18390] = CONST_ANI_ENERGY,
	[18409] = CONST_ANI_FIRE,
	[18411] = CONST_ANI_SMALLEARTH,
	[18412] = CONST_ANI_SMALLICE,
	[2181] = CONST_ANI_SMALLEARTH,
	[2182] = CONST_ANI_EARTH,
	[2183] = CONST_ANI_SMALLICE,
	[2185] = CONST_ANI_DEATH,
	[2186] = CONST_ANI_SMALLICE,
	[2187] = CONST_ANI_FIRE,
	[2188] = CONST_ANI_DEATH,
	[2189] = CONST_ANI_ENERGY,
	[2190] = CONST_ANI_ENERGY,
	[2191] = CONST_ANI_FIRE
}

function getDamage(cid, level, maglevel)
	local wand = getWand(cid)
	local attack = getItemAttack(wand:getUniqueId()) or 0
	local maximum =	0.085 * 1 * attack * maglevel + level/5 + attack
	return maximum*1.1
end

function default(cid, level, maglevel)
	local max_dmg = getDamage(cid, level, maglevel)
	return max_dmg/1.5*-1,max_dmg*0.75*-1
end

function energyValues(cid, level, maglevel)
	return default(cid, level, maglevel)
end
function deathValues(cid, level, maglevel)
	return default(cid, level, maglevel)
end
function earthValues(cid, level, maglevel)
	return default(cid, level, maglevel)
end
function smallearthValues(cid, level, maglevel)
	return default(cid, level, maglevel)
end
function fireValues(cid, level, maglevel)
	return default(cid, level, maglevel)
end
function iceValues(cid, level, maglevel)
	return default(cid, level, maglevel)
end
function smalliceValues(cid, level, maglevel)
	return default(cid, level, maglevel)
end
function holyValues(cid, level, maglevel)
	return default(cid, level, maglevel)
end
function defaultValues(cid, level, maglevel)
	return default(cid, level, maglevel)
end




local energy = Combat()
energy:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
energy:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ENERGY)
energy:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "energyValues")

local death = Combat()
death:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
death:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_DEATH)
death:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "deathValues")

local earth = Combat()
earth:setParameter(COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
earth:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_EARTH)
earth:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "earthValues")

local smallearth = Combat()
smallearth:setParameter(COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
smallearth:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_SMALLEARTH)
smallearth:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "smallearthValues")

local fire = Combat()
fire:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
fire:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_FIRE)
fire:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "fireValues")

local ice = Combat()
ice:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
ice:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ICE)
ice:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "iceValues")

local smallice = Combat()
smallice:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
smallice:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_SMALLICE)
smallice:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "smalliceValues")

local holy = Combat()
holy:setParameter(COMBAT_PARAM_TYPE, COMBAT_HOLYDAMAGE)
holy:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_HOLY)
holy:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "holyValues")

local default = Combat()
default:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
default:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_CAKE)
default:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "defaultValues")


function onUseWeapon(cid, var)
	local wand = getWand(cid)
	local anim = wandAnim[wand:getId()]
	local ret = false

	if (anim == CONST_ANI_ENERGY) then
		return energy:execute(cid, var)	
	elseif (anim == CONST_ANI_FIRE) then
		return fire:execute(cid, var)	
	elseif (anim == CONST_ANI_ICE) then
		return ice:execute(cid, var)	
	elseif (anim == CONST_ANI_SMALLICE) then
		return smallice:execute(cid, var)	
	elseif (anim == CONST_ANI_DEATH) then
		return death:execute(cid, var)	
	elseif (anim == CONST_ANI_EARTH) then
		return earth:execute(cid, var)	
	elseif (anim == CONST_ANI_SMALLEARTH) then
		return smallearth:execute(cid, var)	
	elseif (anim == CONST_ANI_HOLY) then
		return holy:execute(cid, var)	
	else
		return default:execute(cid, var)	
	end
	return ret
end