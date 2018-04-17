loadFuel()
run = true
mode = 0

position={ [x] = 0, [y]=0 }
while run do
	tunnel()
	if ( invFull() or needFuel() ) then
		farthest = position[y]
		goHome()
		depositInv()
		getFuel()
		loadFuel()
		depositInv()
		returnTunnel()
	end
	
end

function invFull()
	turtle.select(16)
	if(turtle.getItemCount()>0) then
		return true
	else
		return false
	end
end

function needFuel()
	if(turtle.getFuelLevel() < arg[1]*2+position[y]+16) then
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

function returnTunnel()
	move(position[y],1)
end

function goHome()
	move(position[y],3)
end

function loadFuel()
	for i=1,16 do
		turtle.select(i)
		while (turtle.getFuelLevel()<(turtle.getFuelLimit()-300) and turtle.refuel(0)==0 ) do
			turtle.refuel(1)
		end
	end
end

function tunnel()
	moveDig(arg[1],0)
	moveDig(4,1)
	moveDig(arg[1],2)
	moveDig(4,3)
	move(4,1)
	moveDig(4,1)
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
			position[x] = position[x]+1
		elseif (mode==1) then
			position[y] = position[y]+1
		elseif (mode==2) then
			position[x] = position[x]-1
		elseif (mode==3) then
			position[y] = position[y]+1
		end
		turtle.digDown()
	end
end

function move( distance, direction)
	face(direction)
	for i=1,distance do
		turtle.forward()
		if (mode==0) then
			position[x] = position[x]+1
		elseif (mode==1) then
			position[y] = position[y]+1
		elseif (mode==2) then
			position[x] = position[x]-1
		elseif (mode==3) then
			position[y] = position[y]+1
		end
	end
end

function face( direction)
	while not direction==mode do
		turtle.turnLeft()
		mode = (mode +1) % 4
	end
end
