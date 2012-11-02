import "mod_math";

/* ------------------------------------------------------------------------- */
function action_heal()

private
	
	int i;
	
	int pos;
	
	int cursor_id;
	
	int speed = 5;
	
	int stop;

end

begin

	fpg_health = load_fpg("fpg/health.fpg");	
	file = fpg_health;

	// espero a que suelte el boton
	while ( global_key_lock )
		frame;
		global_key_lock();
	end
	
	graph = 1;
	
	x = 160;
	y = 210;
	
	cursor_id = action_heal_cursor();
	
	cursor_id.y = y;
	
	// pongo el fondo para los botones
	put(fpg_health, 10, 160, 90);


	while ( !stop )
	
		global_key_lock();
	
		i += speed;
		if ( i> 360000 )
			i -= 360000; // say("angle reset");
		end
		
		pos = 100 * sin( i * 1000 );
		
		//say( pos);
		
		cursor_id.x = 160 + pos;
		
		if ( (!global_key_lock AND jkeys_state[_JKEY_SELECT]) OR mouse.left )
			
			global_key_lock = true;
			
			stop = true;
			
			// say( pos );
			
			switch ( abs(pos) )
				
				case 0..15:
					// say("BUENO!");
					
					data.health += 50;
					data.fun -= 30;
					
				end
				
				case 16..25:
					// say("REGULAR!");
					
					data.health += 10;
					data.fun -= 20;
					
				end
				
				default:
					// say("MALO!");
					
					data.fun -= 50;
					
				end
			
			end
			
		end
	
		frame;
		
	end
	
	// espero a que suelte el boton
	while ( global_key_lock )
		frame;
		global_key_lock();
	end
	
	// espero a que presione boton para salir
	while ( !global_key_lock )
		frame;
		global_key_lock();
		
		if ( (!global_key_lock AND jkeys_state[_JKEY_SELECT]) OR mouse.left )
			global_key_lock = true;
		end
		
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
