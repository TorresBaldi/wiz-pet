/* ------------------------------------------------------------------------- */
function action_play_tateti()

private

	tabla[2][2];
	
	int cursor_id;
	
	int seleccion_x;
	int seleccion_y;
	
	int key_lock;
	
	int vacios = 9;
	
	int turn = 2;
	
	int check_tateti;
	
	int game_end;
	
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
	
		// fin del juego
		if ( key( _t ) OR vacios==0 OR game_end )
			
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
					
					check_tateti = true;
					
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
				
				check_tateti = true;
				
				turn = 1;
			
			end
		
		end
		
		if ( check_tateti )
		
			check_tateti = false;
			
			game_end = check_tateti( &tabla );
			
		end
		
		// muevo el cursor en la pantalla
		cursor_id.x = 90 + ( seleccion_x * 70 );
		cursor_id.y = 50 + ( seleccion_y * 70 );
	
		frame;
		
	end

end

/* ------------------------------------------------------------------------- */
process cursor(x,y)

begin

	graph = map_new(20,20,16);
	
	z = father.z - 10;
	
	map_clear( 0, graph, rgb(255,255,0) );
	
	loop
	
		if ( !exists( father ) )
			//say("borro cursor");
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
			//say("borro fichita");
			break;
		end
	
		frame;
	end

end

function int check_tateti( int pointer tabla )

private

	int tateti_found;

	string line;
	
	int i;

end

begin
	
	/*
	// muestro la matriz por consola
	for ( y=0; y<3; y++ )
	
		for( x=0; x<3; x++)
			line += "[" + tabla[(x*3) + y] + "] ";
		end
		
		say( line );
		line = "";
		
	end
	say("");
	*/
	
	// compruebo coincidencias
	for ( i=0; i<3; i++ )
	
		// verticales
		if ( tabla[(i*3) + 0] + tabla[(i*3) + 0] + tabla[(i*3) + 0] >= 3  )	// compruebo si la linea esta completa
			
			// compruebo tateti
			if ( tabla[(i*3) + 0] == tabla[(i*3) + 1] AND tabla[(i*3) + 0] == tabla[(i*3) + 2] )
				say( "TATETI VERTICAL!!!" );
				tateti_found = true;
			end
			
		end
		
		// horizontales
		if ( tabla[(0*3) + i] + tabla[(1*3) + i] + tabla[(2*3) + i] >= 3  )	// compruebo si la linea esta completa
			
			// compruebo tateti
			if ( tabla[(0*3) + i] == tabla[(1*3) + i] AND tabla[(0*3) + i] == tabla[(2*3) + i] )
				say( "TATETI HORIZONTAL!!!" );
				tateti_found = true;
			end
			
		end
	
	end
	
	// diagonal
	if ( tabla[(1*3) + 1] )	// compruebo si se ocupo el centro
		
		if ( tabla[(0*3) + 0] == tabla[(1*3) + 1] AND tabla[(1*3) + 1] == tabla[(2*3) + 2] )
			say( "TATETI DIAGONAL!!!" );
			tateti_found = true;
		end
		
		if ( tabla[(2*3) + 0] == tabla[(1*3) + 1] AND tabla[(1*3) + 1] == tabla[(0*3) + 2] )
			say( "TATETI DIAGONAL!!!" );
			tateti_found = true;
		end
	
	end
	
	return tateti_found;

end
