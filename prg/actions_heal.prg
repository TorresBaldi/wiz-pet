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

	// espero a que suelte el boton
	while ( global_key_lock )
		frame;
		global_key_lock();
	end
	
	graph = 1;
	
	x = 160;
	y = 60;
	
	cursor_id = action_heal_cursor();
	
	cursor_id.y = y;
	
	// pongo el fondo para los botones
	put(fpg_system, 125, 160, 180);
	put(fpg_health, 3, 160, y);
	put(fpg_health, 10, 160, 180);

	while ( !stop )
	
		global_key_lock();
	
		i += speed;
		if ( i> 360000 )
			i -= 360000;
			// say("angle reset");
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
					
					stats.health += 50;
					stats.fun -= 30;
					
				end
				
				case 16..25:
					// say("REGULAR!");
					
					stats.health += 10;
					stats.fun -= 20;
					
				end
				
				default:
					// say("MALO!");
					
					stats.fun -= 50;
					
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
