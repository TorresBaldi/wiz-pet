/* ------------------------------------------------------------------------- */
function action_die()

private

	int counter;

end

begin

	file = fpg_pet;
	
	graph = 10;
	
	size = 200;
	
	x = 160;
	y = 120;
	
	while ( size > 0 )
	
		size -= 4;
		
		frame;
		
	end
	
	say("die!");
	
	stats.status = STA_DEAD;
	
	menu_avaliable[MENU_CONTINUE] = FALSE;
	menu_avaliable[MENU_START] = TRUE;

end
