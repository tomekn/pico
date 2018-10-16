pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
function _init()
	--player definition
	player = {
		pos = {x = 0, y = 0},
		vel = {x = 0, y = 0 },
		acc = {x = 0, y = 0},
		move_force = 10.0,
		mass = 10.0,
		max_vel = 3
	}

	function player:draw()
		spr(0, self.pos.x, self.pos.y)
	end

	function player:update()
		self.vel = v_addv(self.vel, self.acc)
		self.pos = v_addv(self.pos, self.vel)
		self.acc = v_mults(self.acc, 0)
	end

	function player:move(v)
		if (v_magsqr(self.vel) < self.max_vel*self.max_vel) apply_force(self, v_mults(v, self.move_force))
	end
	-- stars (s=speed c=count m=move_speed, t=trail_length)
	stars_f = {info={s=0, c=0, m=1}, data={}}
	stars_n = {info={s=0, c=0, m=3}, data={}}
	stars_c = {info={s=0, c=0, m=6}, data={}}

	for i=1,16 do
		add(stars_f.data, {x=rnd(128),y=rnd(128)})
		add(stars_n.data, {x=rnd(128),y=rnd(128)})
		add(stars_c.data, {x=rnd(128),y=rnd(128)})
	end
end
-->8
function _update()
	handle_player()
end

function handle_player()
	player:move(get_input())

	if (abs(v_mag(player.vel)) > 0.3) then
		local friction = player.vel
		friction = v_mults(v_normalize(friction),-1)
		friction = v_mults(friction, 2)

		apply_force(player, friction)
	else
		player.vel = {x=0,y=0}
	end

	player:update()
	update_stars(stars_f)
	update_stars(stars_n)
	update_stars(stars_c)
end

function get_input()
	local move_vector = {x=0,y=0}
	if (btn(⬅️)) move_vector = v_addv(move_vector, {x=-1,y=0})
	if (btn(➡️)) move_vector = v_addv(move_vector, {x=1,y=0})
	if (btn(⬆️)) move_vector = v_addv(move_vector, {x=0,y=-1})
	if (btn(⬇️)) move_vector = v_addv(move_vector, {x=0,y=1})
	return v_normalize(move_vector)
end

function update_stars(stars)
	stars.info.c +=1
	if stars.info.c > stars.info.s then
		for s in all (stars.data) do
			s.y += stars.info.m
			if (s.y > 127) then
				s.x = rnd(127)
				s.y = 0
			end
		end
		stars.info.c = 0
	end
end
-->8
function _draw()
	cls()
	draw_stars(stars_f, 7)
	draw_stars(stars_n, 6)

	player:draw()

	draw_stars(stars_c, 5)
end

function draw_stars(stars, color)
	length = stars.info.m
	for s in all (stars.data) do
		for i=1,length do
			pset(s.x, s.y-(length-i), color)
		end
	end
end
-->8
-- utility methods
function lerp(tar,pos,perc)
	return (1-perc)*tar + perc*pos;
end

function apply_force(obj, force)
	local mf = v_divs(force, obj.mass)
	obj.acc = v_addv(obj.acc, mf)
end

--Methods for handling math between 2D vectors
-- Vectors are tables with x,y variables inside

-- Contributors: WarrenM


-- Add v1 to v2
function v_addv( v1, v2 )
  return { x = v1.x + v2.x, y = v1.y + v2.y }
end

-- Subtract v2 from v1
function v_subv( v1, v2 )
  return { x = v1.x - v2.x, y = v1.y - v2.y }
end

-- Multiply v by scalar n
function v_mults( v, n )
  return { x = v.x * n, y = v.y * n }
end

-- Divide v by scalar n
function v_divs( v, n )
  return { x = v.x / n, y = v.y / n }
end

-- Gets magnitude of v, squared (faster than v_mag)
function v_magsqr( v )
  return ( v.x * v.x ) + ( v.y * v.y )
end

-- Compute magnitude of v
function v_mag( v )
  return sqrt( ( v.x * v.x ) + ( v.y * v.y ) )
end

-- Normalizes v into a unit vector
function v_normalize( v )
  local len = v_mag( v )
  return { x = v.x / len, y = v.y / len }
end

-- Computes dot product between v1 and v2
function v_dot( v1, v2 )
   return ( v1.x * v2.x ) + ( v1.y * v2.y )
end

-- Computes the reflection vector between vector v and normal n
-- NOTE : assumes v and n are normalized
function v_reflect( v, n )
  local dot = v_dot( v, n )
  local wdnv = v_mults( v_mults( n, dot ), 2.0 )
  local refv = v_subv( v, wdnv )
  return refv
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00067000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00676700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
05676750090000900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
06d67c70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
666dc777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
08900980000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000001010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000010101010101010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
00010000320502b050240501a050150501105011050130501405015050190502d0502b050100503f05029050090502505038050180501f05018050040501a05015050120500f0500d0500b0500b0500000000000
