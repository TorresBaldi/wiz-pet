//debug
function reset()

begin

	stats.hambre = 100;
	stats.salud = 100;
	stats.diversion = 100;
	stats.higiene = 100;
	stats.energia = 100;
	
	stats.ticks = 0;
	stats.edad = 0;
	
	stats.first_time = time();
	stats.last_time = time();
	
	timer[0] = tick;
	
	while( jkeys_state[ _JKEY_L ] )
		frame;
	end

end
