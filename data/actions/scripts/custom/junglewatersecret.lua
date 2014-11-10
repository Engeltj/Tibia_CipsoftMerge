function onUse(cid, item, frompos, topos) 
if item.actionid==2035 then
	doTeleportThing(cid, {x = 2332, y = 1669, z = 8})
	doSendMagicEffect(getPlayerPosition(cid), 12)
end
end