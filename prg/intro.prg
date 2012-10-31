/* ------------------------------------------------------------------------- */
function start_intro( int skippable )

private
	
	int current = 1;
	int max = 3;

end

begin

	
	fade_off();
	while ( fading )
		frame;
	end
	
	file = load_fpg("intro.fpg");
	put_screen( file, current );
	
	fade(100,100,100,4);
	while ( fading )
		frame;
	end

	loop
	
		// salteo la presentacion
		if ( skippable AND (jkeys_state[_JKEY_SELECT] or mouse.left) )
			timer[0] = 400 * current;
		end
		
		if ( timer[0] > (400 * current) )
		
			current++;
			
			intro_transition(5);
			
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

process intro_transition( speed )

begin

	file = 0;
	graph = get_screen();
	
	x = 160; 
	y = 120;

	while ( alpha > 0 )
	
		size += speed;
		alpha -= speed;
		
		frame;
		
	end

end
