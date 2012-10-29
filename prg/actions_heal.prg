import "mod_math";

/* ------------------------------------------------------------------------- */
function action_heal()

private

	int seleccion;
	
	int i;
	
	int pos;
	
	int cursor_id;
	
	int speed = 5;
	
	int stop;

end

begin

	fpg_health = load_fpg("fpg/health.fpg");
	
	file = fpg_health;
	
	graph = 1;
	
	x = 160;
	y = 120;
	
	cursor_id = action_heal_cursor();
	
	cursor_id.y = 120;
	
	while ( !stop )
	
		i += speed;
		if ( i> 360000 ) i -= 360000; say("angle reset"); end
		
		pos = 100 * sin( i * 1000 );
		
		//say( pos);
		
		cursor_id.x = 160 + pos;
		
		if ( !global_key_lock AND jkeys_state[_JKEY_SELECT] )
			
			global_key_lock = true;
			
			stop = true;
			
			say( pos );
			
			switch ( abs(pos) )
				
				case 0..15:
					say("BUENO!");
					
					stats.health += 50;
					stats.fun -= 30;
					
				end
				
				case 16..25:
					say("REGULAR!");
					
					stats.health += 10;
					stats.fun -= 20;
					
				end
				
				default:
					say("MALO!");
					
					stats.fun -= 50;
					
				end
			
			end
			
		end
	
		frame;
		
	end
	
	while ( jkeys_state[_JKEY_SELECT] OR mouse.left )
		frame;
	end
	while ( !jkeys_state[_JKEY_SELECT] AND !mouse.left )
		frame;
	end

end

process action_heal_cursor()

begin

	file = father.file;
	graph = 2;
	z = father.z -1;

	loop
	
		if ( !exists(father) )
			break;
		end
	
		frame;
		
	end

end