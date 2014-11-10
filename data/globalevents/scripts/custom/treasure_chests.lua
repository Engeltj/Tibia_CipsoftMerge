function onStartup()
	local chests = {
		{x = 2279, y = 2222, z = 8, stackpos=255},
		{x = 2100, y = 2248, z = 8, stackpos=255},
		{x = 2250, y = 2320, z = 8, stackpos=255},
		{x = 2479, y = 2333, z = 7, stackpos=255},
		{x = 2530, y = 2367, z = 7, stackpos=255},
		{x = 2511, y = 2332, z = 5, stackpos=255},
		{x = 2592, y = 2323, z = 7, stackpos=255},
		{x = 2426, y = 2302, z = 8, stackpos=255},
		{x = 2332, y = 1670, z = 8, stackpos=255},
		{x = 2332, y = 1668, z = 8, stackpos=255},
		{x = 2487, y = 1742, z = 6, stackpos=255},
		{x = 2464, y = 1720, z = 8, stackpos=255},
		{x = 2461, y = 1718, z = 8, stackpos=255},
		{x = 2447, y = 1700, z = 8, stackpos=255},
		{x = 2292, y = 1712, z = 8, stackpos=255},	
	    {x = 2354, y = 1717, z = 8, stackpos=255},
		{x = 2426, y = 2302, z = 8, stackpos=255},
		{x = 2383, y = 2290, z = 3, stackpos=255},
		{x = 2517, y = 2265, z = 8, stackpos=255},
		{x = 2241, y = 2083, z = 8, stackpos=255},
		{x = 2240, y = 2084, z = 8, stackpos=255},
		{x = 2606, y = 2389, z = 12, stackpos=255},
		{x = 2619, y = 2410, z = 13, stackpos=255},
		{x = 2619, y = 2418, z = 14, stackpos=255},
		{x = 2703, y = 2438, z = 14, stackpos=255},
		{x = 2456, y = 2198, z = 8, stackpos=255},
		{x = 2608, y = 2221, z = 8, stackpos=255},
		{x = 2507, y = 2225, z = 9, stackpos=255},
		{x = 2602, y = 2307, z = 9, stackpos=255},
		{x = 2593, y = 2286, z = 12, stackpos=255},
		{x = 2540, y = 2224, z = 12, stackpos=255},
		{x = 2588, y = 2226, z = 11, stackpos=255},
		{x = 2595, y = 2225, z = 12, stackpos=255},
		{x = 2754, y = 2441, z = 15, stackpos=255},
		{x = 2796, y = 2421, z = 14, stackpos=255},
		{x = 2854, y = 2450, z = 14, stackpos=255},
		{x = 2815, y = 2406, z = 14, stackpos=255},
		{x = 2790, y = 2455, z = 15, stackpos=255},
		{x = 2791, y = 2455, z = 15, stackpos=255},
		{x = 2792, y = 2455, z = 15, stackpos=255},
		{x = 2370, y = 2149, z = 6,  stackpos=255},
		{x = 2147, y = 2126, z = 8,  stackpos=255},
		{x = 2148, y = 2126, z = 8,  stackpos=255},
		{x = 2150, y = 2127, z = 8,  stackpos=255},
		{x = 2108, y = 2197, z = 8,  stackpos=255},
		{x = 2270, y = 2102, z = 6,  stackpos=255},
		{x = 2267, y = 2108, z = 6,  stackpos=255},
		{x = 2368, y = 2342, z = 7,  stackpos=255},
		{x = 2280, y = 2169, z = 7,  stackpos=255},
		{x = 2180, y = 2227, z = 6,  stackpos=255},
		{x = 2182, y = 2227, z = 6,  stackpos=255},
		{x = 2451, y = 2272, z = 7,  stackpos=255},
		{x = 2452, y = 2226, z = 7,  stackpos=255},
		{x = 2391, y = 2232, z = 5,  stackpos=255},
		{x = 2394, y = 2233, z = 6,  stackpos=255},
		{x = 2392, y = 2340, z = 7,  stackpos=255},
		{x = 2204, y = 2359, z = 0,  stackpos=255},
		{x = 2202, y = 2359, z = 0,  stackpos=255},
		{x = 2271, y = 2337, z = 7,  stackpos=255},
		{x = 2200, y = 2333, z = 7,  stackpos=255},
		{x = 2063, y = 2173, z = 9,  stackpos=255},
		{x = 2005, y = 2136, z = 9,  stackpos=255},
		{x = 2155, y = 2184, z = 9,  stackpos=255},
		{x = 2104, y = 2107, z = 9,  stackpos=255},
		{x = 2091, y = 2138, z = 8,  stackpos=255},
		{x = 2103, y = 2165, z = 8,  stackpos=255},
		{x = 2199, y = 2231, z = 7,  stackpos=255},
		{x = 2235, y = 2286, z = 7,  stackpos=255},
		{x = 2235, y = 2291, z = 7,  stackpos=255},
		{x = 2223, y = 2164, z = 8,  stackpos=255},
		{x = 2131, y = 2241, z = 8,  stackpos=255},
		{x = 2183, y = 2260, z = 8,  stackpos=255},
		{x = 2270, y = 2274, z = 8,  stackpos=255},
		{x = 2224, y = 1985, z = 9,  stackpos=255},
		{x = 2325, y = 2399, z = 10, stackpos=255},
		{x = 2701, y = 2438, z = 14, stackpos=255}
		
	}
	
	
	for i, position in ipairs(chests) do
		local item = doCreateItemEx(5676)
		doItemSetAttribute(item, 'aid', 2016)
		doTileAddItemEx(position, item)
	end
	
	-- for x=0,4096 do
		-- local pos = {x=math.random(1,4096),y=math.random(1,4096),z=math.random(0,15), stackpos=255}
		-- item = doCreateItemEx(1979, 1)
		-- local pos2 = getClosestFreeTile(item, pos, true, true)
		-- doTileAddItemEx(pos2, item)
	-- end
	-- for a=1,5 do
		-- for b=1,5 do
			-- for c=6,7 do
				-- local pos = {x=a,y=b,z=c,stackpos=1}
				-- local items = {}
				-- --getThingFromPos(pos)
				-- local tile = getTileInfo(pos)
				-- --oBroadcastMessage("The tables have turned! ")
				-- -- if tile == true then
					-- -- itens = tile.items
					-- -- for i = itens, 1, -1 do
						-- -- pos.stackpos = i
						-- -- -- items[i] = getThingFromPos(pos)
					-- -- end
				-- -- end
				
				
				-- --local item = getThingfromPos(pos).uid
				
				-- -- if item.uid > 0 then 
					-- -- local pos2 = getClosestFreeTile(item.uid, pos, false, true)
					-- -- if (pos2 ~= nil) and pos2 > 0 then
						-- -- pos2.stackpos = 255
						
						-- -- if pos == pos2 then
							-- -- doCreateItem(1979, 1, pos)
						-- -- end
					-- -- end
				-- -- end
			-- end
		-- end
	-- end
	
	
	return true
end
