//debug
function reset()

begin

	data.food = 100;
	data.health = 100;
	data.fun = 100;
	data.clean = 100;
	data.shower = 100;

	data.ticks = 0;
	data.age = AGE_BABY;
	
	//data.location = LOC_INSIDE;
	
	// lo revivo
	data.status = STA_NORMAL;

	clean_caca(0);
	clean_caca(1);

	data.first_time = time();
	data.last_time = time();
	
	update_mood();

end
