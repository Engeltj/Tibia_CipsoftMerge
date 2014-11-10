function onSay(cid, words, param)
	local param = string.explode(param, ",")
	
	if(param == '') then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Command requires param.")
		return true
	end
	local type_outfit = tonumber(param[1])
	if type_outfit < 523 and not (type_outfit >= 475 and type_outfit <= 484) and not (type_outfit >= 161 and type_outfit <= 191) and not (type_outfit >= 0 and type_outfit <= 1)  then
		local outfit = {lookType = tonumber(param[1]), lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookTypeEx = 0, lookAddons = 0}
		--outfit.lookType = tonumber(param[1])
		doCreatureChangeOutfit(cid, outfit)
		doSendMagicEffect(getPlayerPosition(cid),26)
	else
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Uhg, debugs past this point in values.")
		return true
	end
	return true
end