/* ------------------------------------------------------------------------- */
PROCESS show_credits()

private

	int t;

end

begin

	file = fpg_system;
	graph = 20;
	x = 160;
	y = 0;
	
	set_center( file, graph, 160, 0 );
	
	while( t < 100 );
		t++;
		frame;
	end

	while ( y > -860 + 240 )
		y--;
		frame;
	end
	
	while( t < 200 );
		t++;
		frame;
	end
	
	open_main_menu = true;

end
