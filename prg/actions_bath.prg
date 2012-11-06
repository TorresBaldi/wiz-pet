/* ------------------------------------------------------------------------- */
function action_bath()

private

	int seleccion;
	
	int counter;
	
	int counter_total = 200;

end

begin

	fpg_shower = load_fpg( "fpg/shower.fpg" );

	x = 160;
	y = 20;
	
	put_screen(fpg_bg, 9);
	
	bath_water();
	bath_pet();

	while ( data.shower < 100 )
	
		data.shower += 0.5;
		counter = data.shower;
	
		unload_map( 0, graph );
		graph = draw_bar(counter, 200, 12);
	
		frame;
	
	end
	
ONEXIT

	unload_fpg( fpg_shower );
	
	signal( id, S_KILL_TREE );

end

process bath_pet()

begin

	file = fpg_shower;
	
	graph = 100 + (data.age * 100);
	
	x = 160;
	y = 120;

	loop

		frame;
		
	end
	
end

process bath_water()

private

	int i;

end

begin

	file = fpg_shower;
	
	graph = 1;
	
	x = 160;
	y = 120;

	loop
	
		i++;
		
		if ( i % 10 == 0 )
		
			i=0;
			
			graph++;
			
			if ( graph > 2 )
				graph = 1;
			end
			
		end

		frame;
		
	end
	
end

/* ------------------------------------------------------------------------- */
function action_nobath();

begin

end


