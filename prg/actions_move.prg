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

	prev_graph = data.location;
	
	if ( data.location == LOC_INSIDE )	
		data.location = LOC_OUTSIDE;
	else
		direction = true;
		data.location = LOC_INSIDE;
	end

	// actualizo la limpieza del lugar
	data.clean = 100;
	for ( i=0; i <= 5; i++ )
		if ( data.dump[ data.location-1 ][i][0] )
			data.clean -= 20;
		end
	end

	// hago la animacion
	x = 160;
	movement = 0; // cantidad de movimiento
	while ( movement < 320 )

		movement += speed;
		
		put( fpg_bg, prev_graph,x, 120 );
		
		if ( direction )
			put( fpg_bg, data.location, x + 320, 120 );
			x -= speed;
		else
			put( fpg_bg, data.location, x - 320, 120 );
			x += speed;
		end
		

		frame;

	end

	//debug;

end
