
function onUse(cid, item, fromPos, itemEx, toPos)
	if (itemEx.actionid == 2044) and (itemEx.itemid ~= item.itemid) then
		doTeleportThing(cid, toPos)
		addEvent(doTeleportThing, 150, cid, {x=toPos.x,y=toPos.y+1,z=toPos.z})
		doSendMagicEffect(toPos, 66)
	elseif (itemEx.actionid ~= 2044) then
		doPlayerSendCancel(cid, "Sorry, this tree isn't strong enough to support you")
	end
	return true
end