/* ------------------------------------------------------------------------- */
function action_move()

private

	int prev_graph;
	int movement;
	int direction;
	
	int i;
	
	int speed = 5;

end

begin

	prev_graph = stats.location;
	
	if ( stats.location == LOC_INSIDE )	
		stats.location = LOC_OUTSIDE;
		direction = true;
	else
		stats.location = LOC_INSIDE;
	end

	// actualizo la limpieza del lugar
	i = 0;	// uso z como i;
	stats.clean = 100;
	for ( i=0; i <= 5; i++ )
		if ( stats.dump[ stats.location-1 ][i][0] )
			stats.clean -= 20;
		end
	end

	// hago la animacion
	x = 160;
	movement = 0;
	while ( movement < 320 )

		movement += speed;
		

		if ( direction )
			put( fpg_bg, stats.location, x + 320, 120 );
			x -= speed;
		else
			put( fpg_bg, stats.location, x - 320, 120 );
			x += speed;
		end
		
		put( fpg_bg, prev_graph,x, 120 );
		

		frame;

	end

	//debug;

end
