/* ------------------------------------------------------------------------- */
function action_move()

begin

	if ( stats.location == 1 )
		y = 1;
		stats.location = 2;
	else
		y = 2;
		stats.location = 1;
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
