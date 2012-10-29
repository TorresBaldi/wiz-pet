/* ------------------------------------------------------------------------- */
function action_move()

begin

	caca_updated = true;
	
	if ( stats.location == LOC_INSIDE )
		y = 1;
		stats.location = LOC_OUTSIDE;
	else
		y = 2;
		stats.location = LOC_INSIDE;
	end
	
	while ( action_transition )
		frame;
	end
	
	x = 160;
	while ( x < 320 + 160 )
	
		x += 5;
		
		put( fpg_bg, y, x, 120 );
		put( fpg_bg, stats.location, -320 + x, 120 );
		
		frame;
		
	end
	
end
