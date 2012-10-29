/* ------------------------------------------------------------------------- */
function action_bath()

private

	int seleccion;
	
	int counter;

end

begin

	x = 160;
	y = 120;
	
	graph = draw_bar(counter, 200, 50);

	while ( counter < 100 )
	
		unload_map( 0, graph );
		graph = draw_bar(counter, 200, 50);
		
		counter++;
	
		frame;
	
	end
	
	stats.shower += 20;

end
