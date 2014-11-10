function onSay(cid, words, param)
	for x=1,32 do
		doPlayerAddMount(cid, x)
	end
	return true
end