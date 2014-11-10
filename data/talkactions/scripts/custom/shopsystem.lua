function onSay(cid, words, param)
	if(param == "") then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Invalid Syntax.. [ITEMID], [PRICE]")
		return true
	end
	local t = string.explode(param, ",")
	-- if (t[1] == 'add') or (t[1] == 'edit') then
		-- if (not t[3]) then
			-- doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Invalid Syntax.. [edit/add/remove], [ITEMID], [PRICE]")
			-- return true
		-- end
	-- elseif (not t[2]) or (t[1] ~= 'remove') then
		-- doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Invalid Syntax.. [edit/add/remove], [ITEMID], [PRICE]")
		-- return true
	-- end
	
	if t[1] == 'add' then
		local result = mysqlQuery("SELECT item_id FROM shop_system WHERE shop_system.item_id = '"..t[2].."'")
		if result ~= nil then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "[ERROR] Item already exists in shop. Use 'edit' instead.")
			return false
		end
		mysqlQuery("INSERT INTO shop_system (item_id, price) VALUES ("..t[2]..", "..t[3]..")", "set")
	end
	-- if (t[1] == 'edit') or (t[1] == 'remove') then
		-- if (result_plr:getID() ~= -1) then
			-- result_plr:free()
		-- else
			-- doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "[ERROR] Item does not exist in shop. Use 'add' instead.")
			-- return false
		-- end
		-- if (t[1] == 'edit') then
			-- mysqlQuery("UPDATE `shop_system` SET `price` = "..t[3]..", WHERE `item_id`  = " ..t[2].. ";")
			-- doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "[SUCCESS] Item " ..t[2].. " updated.")
			-- return true
		-- else
			-- mysqlQuery("DELETE FROM `shop_system` WHERE `item_id` = "..t[2]..";")
			-- doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "[SUCCESS] Item " ..t[2].. " removed.")
			-- return true
		-- end
	-- elseif (t[1] == 'add') then
		-- if (result_plr:getID() ~= -1) then
			-- doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "[ERROR] Item already exists in shop. Use 'edit' or 'remove' instead.")
			-- return false
		-- end
	-- end
	-- result_plr:free()
	return false
end