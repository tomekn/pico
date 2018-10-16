pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
function _init()
	--player definition
	player = {
		xpos=64,
		ypos=64
	}
	
	function player:draw()
		spr(0,self.xpos, self.ypos)
	end
	
	function player:move(d)
		if (d==⬅️) self.xpos = self.xpos - 1
		if (d==➡️) self.xpos = self.xpos + 1
		if (d==⬆️) self.ypos = self.ypos - 1
		if (d==⬇️) self.ypos = self.ypos + 1
	end
end
-->8
function _update()
	if (btnp(⬅️)) then
		player:move(⬅️)
	end

	if (btnp(➡️)) then
		player:move(➡️)
	end
	
	if (btnp(⬆️)) then
		player:move(⬆️)
	end
	
	if (btnp(⬇️)) then
		player:move(⬇️)
	end
end
-->8
function _draw()
	cls()
	player:draw()
end
