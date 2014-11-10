function onStepIn(cid, item, toPos, itemEx, fromPos)

 local pos=getPlayerPosition(cid)
 local left={x=pos.x-1 , y=pos.y, z=pos.z ,stackpos=1}
 local right={x=pos.x+1 ,y=pos.y, z=pos.z, stackpos=1}
 local le={x=pos.x-1 , y=pos.y+1, z=pos.z, stackpos=1}
 local rig={x=pos.x+1 ,y=pos.y+1, z=pos.z, stackpos=1}

		if item.actionid == 9204 then
			--if getThingFromPos(left).itemid==1485 then
			doTransformItem(getThingFromPos(left).uid,1484)
			doTransformItem(getThingFromPos(right).uid,1484)
			doSendMagicEffect(pos,12)
		end		
			if item.acionid ==9205 then	
			doTransformItem(getThingFromPos(left).uid,1484)
			doTransformItem(getThingFromPos(right).uid,1484)	
			doTransformItem(getThingFromPos(lef).uid,1484)
			doTransformItem(getThingFromPos(righ).uid,1484)		
			
		end	
		return true
end	
		
function onStepOut(cid, item, toPos, itemEx, fromPos)

 local pos=getPlayerPosition(cid)
 local left={x=pos.x-1 , y=pos.y-1, z=pos.z, stackpos=1}
 local right={x=pos.x+1 ,y=pos.y-1, z=pos.z, stackpos=1}
 local lef={x=pos.x-1 , y=pos.y+1, z=pos.z, stackpos=1}
 local righ={x=pos.x+1 ,y=pos.y+1, z=pos.z, stackpos=1}

		if item.actionid == 9204 then
			--if getThingFromPos(lef).itemid==1484 then
			doSendMagicEffect(pos,12)
			doTransformItem(getThingFromPos(left).uid,1485)
			doTransformItem(getThingFromPos(right).uid,1485)
			doTransformItem(getThingFromPos(lef).uid,1485)
			doTransformItem(getThingFromPos(righ).uid,1485)	
			end	
			if item.acionid ==9205 then	
			doTransformItem(getThingFromPos(lef).uid,1485)
			doTransformItem(getThingFromPos(righ).uid,1485)	
		end
		return true
end