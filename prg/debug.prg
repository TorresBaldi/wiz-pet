//debug
function reset()

begin

	stats.food = 100;
	stats.health = 100;
	stats.fun = 100;
	stats.clean = 100;
	stats.shower = 100;
	stats.sleep = 100;

	stats.ticks = 0;
	stats.age = 0;

	clean_caca(0);
	clean_caca(1);

	stats.first_time = time();
	stats.last_time = time();

	timer[0] = tick;

	while( jkeys_state[ _JKEY_L ] )
		frame;
	end

end