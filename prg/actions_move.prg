/* ------------------------------------------------------------------------- */
function action_move()

begin

	if ( stats.lugar == 1 )
		y = 1;
		stats.lugar = 2;
	else
		y = 2;
		stats.lugar = 1;
	end
	
	while ( action_transition )
		frame;
	end
	
	x = 160;
	while ( x < 320 + 160 )
	
		x += 5;
		
		put( fpg_bg, y, x, 120 );
		put( fpg_bg, stats.lugar, -320 + x, 120 );
		
		frame;
		
	end
	
end
