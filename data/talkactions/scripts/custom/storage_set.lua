function onSay(cid, words, param)
	local param = string.explode(param, " ")
	if #param ~= 2 then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Syntax: <ID> <value>")
		return true
	end
	doCreatureSetStorage(cid, tonumber(param[1]), tonumber(param[2]))
	
	return true
end
