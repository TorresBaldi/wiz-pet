/* ------------------------------------------------------------------------- */
function action_move()

begin
	
	if ( stats.location == LOC_INSIDE )
		y = 1;
		stats.location = LOC_OUTSIDE;
	else
		y = 2;
		stats.location = LOC_INSIDE;
	end
	
	// actualizo la limpieza del lugar
	z = 0;	// uso z como i;
	stats.clean = 100;
	for ( z=0; z <= 5; z++ )
		
		if ( stats.dump[stats.location -1][z][0] )
		
			stats.clean -= 20;
		
		end
		
	end
	
	x = 160;
	while ( x < 320 + 160 )
	
		x += 5;
		
		put( fpg_bg, y, x, 120 );
		put( fpg_bg, stats.location, -320 + x, 120 );
		
		frame;
		
	end
	
	//debug;
	
end
