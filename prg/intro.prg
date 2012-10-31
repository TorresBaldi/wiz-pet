/* ------------------------------------------------------------------------- */
function start_intro( int skippable )

private

	int timer;
	
	int current = 1;
	int max = 3;

end

begin

	file = load_fpg("intro.fpg");
	
	put_screen( file, current );

	loop
	
		timer++;
		
		if ( timer > 100 )
		
			timer = 0;
			current++;
			intro_transition();
			
			if ( current > max )
				break;
			end
		
			put_screen( file, current );
		
		end
	
		frame;
		
	end
	
onexit

	unload_fpg( file );

end

process intro_transition()

begin

	file = 0;
	graph = get_screen();
	
	x = 160; 
	y = 120;

	while ( alpha > 0 )
	
		size += 4;
		alpha -= 4;
		
		frame;
		
	end

end
