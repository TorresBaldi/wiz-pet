/* ------------------------------------------------------------------------- */
process actions_manager()

private
	
	int activated;

end

begin

	signal_action( S_SLEEP_TREE, S_IGN);

	loop
	
		if ( do_action )
		
			switch ( do_action )
			
				// tateti
				case 1:
				
					say("start tateti");
					play_tateti();
				
				end
			
			end
			
			say("action done!");
			do_action = false;
	
		end
	
		frame;
		
	end

end


function play_tateti()

private

	tabla[2][2];
	
	int cursor_id;
	
	int seleccion_x;
	int seleccion_y;
	
	int key_lock;
	
	int vacios = 9;
	
	int turn = 2;
	
end

begin

	file = load_fpg( "fpg/tateti.fpg" );
	graph = 1;
	
	x = 160;
	y = 120;
	
	cursor_id = cursor(90,50);
	
	while ( jkeys_state[_JKEY_SELECT] )
		frame;
	end
	
	loop
	
		// aborto
		if ( key( _t ) or vacios == 0)
			
			stats.diversion += 30;
			
			break;
			
		end
		
		if ( key_lock )
			
			if ( !jkeys_state[_JKEY_DOWN] AND !jkeys_state[_JKEY_RIGHT] AND !jkeys_state[_JKEY_UP] AND !jkeys_state[_JKEY_LEFT] AND !jkeys_state[_JKEY_SELECT])
				key_lock = false;
			end
			
		else
		
		
			if ( turn == 1 )
				
				// movimiento del cursor
				if ( jkeys_state[_JKEY_RIGHT] )
					key_lock = true;
					seleccion_x = (seleccion_x+1)%3;
				elseif (jkeys_state[_JKEY_LEFT] )
					key_lock = true;
					seleccion_x--;
					if ( seleccion_x<0 ) seleccion_x = 2; end
				elseif (jkeys_state[_JKEY_DOWN] )
					key_lock = true;
					seleccion_y = (seleccion_y+1)%3;
				elseif (jkeys_state[_JKEY_UP] )
					key_lock = true;
					seleccion_y--;
					if ( seleccion_y<0 ) seleccion_y = 2; end
				end
				
				// agrego items
				if ( jkeys_state[_JKEY_SELECT] AND tabla[seleccion_x][seleccion_y] == 0 )
				
					key_lock = true;
					
					piece( 90 + ( seleccion_x * 70 ), 50 + ( seleccion_y * 70 ), turn );
					
					tabla[seleccion_x][seleccion_y] = turn;
					
					vacios--;
					
					turn = 2;
				
				end
				
			else
			
				// turno de la maquina
				seleccion_x = rand (0,2);
				seleccion_y = rand (0,2);
				
				while ( tabla[seleccion_x][seleccion_y] <> 0 )
					seleccion_x = rand (0,2);
					seleccion_y = rand (0,2);
				end
				
				piece( 90 + ( seleccion_x * 70 ), 50 + ( seleccion_y * 70 ), turn );
				
				tabla[seleccion_x][seleccion_y] = turn;
				
				vacios--;
				
				turn = 1;
			
			end
		
		end
		
		// muevo el cursor en la pantalla
		cursor_id.x = 90 + ( seleccion_x * 70 );
		cursor_id.y = 50 + ( seleccion_y * 70 );
	
		frame;
		
	end

end

process cursor(x,y)

begin

	graph = map_new(20,20,16);
	
	z = father.z - 10;
	
	map_clear( 0, graph, rgb(255,255,0) );
	
	loop
	
		if ( !exists( father ) )
			say("borro cursor");
			break;
		end
	
		frame;
	end

onexit
	
	map_unload( 0, graph );

end


process piece(x,y,turn)

begin

	file = father.file;
	z = father.z - 20;
	graph = turn+1;

	loop
	
		if ( !exists( father ) )
			say("borro fichita");
			break;
		end
	
		frame;
	end

end
