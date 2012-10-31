/* ------------------------------------------------------------------------- */
function action_move()

private

	int next_graph;
	int movement;

end

begin

	if ( stats.location == LOC_INSIDE )
		next_graph = 1;
		stats.location = LOC_OUTSIDE;
	else
		next_graph = 2;
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

		put( fpg_bg, next_graph, x, 120 );
		put( fpg_bg, stats.location, -320 + x, 120 );

		frame;

	end

	//debug;

end
