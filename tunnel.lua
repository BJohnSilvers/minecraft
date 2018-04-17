local arg = {...}
mode = 0

function face( direction)
	while direction!=mode do
		turtle.turnLeft()
		mode = (mode +1) % 4
	end
end

function invFull()
	for i=1,16 do
		turtle.select(i)
		if(turtle.getItemCount()==0) then
			return false
		end
	end
	return true
end

function needFuel()
	if(turtle.getFuelLevel() < arg[1]*2+position["y"]+16) then
		return true
	else
		return false
	end
end

function depositInv()
	face(2)
	for i=1,16 do
		turtle.select(i)
		drop()
	end
end

function getFuel()
	face(3)
	turtle.suck()
end

function loadFuel()
	for i=1,16 do
		turtle.select(i)
		while (turtle.getFuelLevel()<(turtle.getFuelLimit()-300) and turtle.refuel(0)!=0 ) do
			turtle.refuel(1)
		end
	end
end

function moveDig( distance, direction)
	face(direction)
	for i=1,distance do
		while turtle.detect() do
			turtle.dig()
			sleep(0.25)
		end
		turtle.forward()
		if (mode==0) then
			position["x"] = position["x"]+1
		elseif (mode==1) then
			position["y"] = position["y"]+1
		elseif (mode==2) then
			position["x"] = position["x"]-1
		elseif (mode==3) then
			position["y"] = position["y"]+1
		end
		turtle.digDown()
	end
end

function move( distance, direction)
	face(direction)
	for i=1,distance do
		turtle.forward()
		if (mode==0) then
			position["x"] = position["x"]+1
		elseif (mode==1) then
			position["y"] = position["y"]+1
		elseif (mode==2) then
			position["x"] = position["x"]-1
		elseif (mode==3) then
			position["y"] = position["y"]+1
		end
	end
end

function goHome()
	move(position.y,3)
end

function tunnel()
	moveDig(arg[1],0)
	moveDig(4,1)
	moveDig(arg[1],2)
	moveDig(4,3)
	move(4,1)
	moveDig(4,1)
end


loadFuel()
run = true
mode = 0

position={ }
position.x=0
position.y=0
while run do
	tunnel()
	if ( invFull() or needFuel() ) then
		farthest = position["y"]
		goHome()
		depositInv()
		getFuel()
		loadFuel()
		depositInv()
		move(farthest, 1)
	end
	
end


