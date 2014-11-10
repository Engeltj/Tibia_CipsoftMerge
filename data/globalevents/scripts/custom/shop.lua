function stockShop()
	print ("Stocking shop ..")
	for i, tile in ipairs(shop_tiles) do
		createShopItem(tile, 100)
	end
	addEvent(stockShop, 60*60*1000) --1hr
end

function onStartup()
	addEvent(stockShop, 2000)
	return true
end
