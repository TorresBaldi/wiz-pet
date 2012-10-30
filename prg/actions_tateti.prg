/* ------------------------------------------------------------------------- */
function action_play_tateti()

private

	tabla[2][2];
	
	btn_selected[2][2];
	btn_activated[2][2];
	
	int activated;

	int cursor_id;

	int seleccion_x;
	int seleccion_y;

	int key_lock;

	int empty = 9;

	int turn = 2;

	int check_tateti;

	int game_result;
	int game_end;

end

begin

	file = load_fpg( "fpg/tateti.fpg" );

	//cursor_id = cursor(90,50);

	while ( jkeys_state[_JKEY_SELECT] or mouse.left )
		frame;
	end
	
	btn_selected[0][0] = true;
	
	for ( x=0; x<3; x++ )
		for ( y=0; y<3; y++ )
		
			// alterno los colores
			if ( (x%2 + y%2) == 1 )
				graph = 200;
			else
				graph = 202;
			end
			
			// creo los botones
			gui_button( 90 + ( x * 70), 50 + (y * 70), graph, &btn_selected[x][y], &btn_activated[x][y] );
			
			//say( x + ", "+ y + ": " + graph );
			
		end
	end
	

	loop

		global_key_lock();

		// fin del juego
		if ( empty==0 OR game_end )

			switch (game_result)

				case 0:
					say("EMPATE");
					stats.fun += 5;
				end

				case 1:
					say("GANA JUGADOR");
					stats.fun += 30;
				end

				case 2:
					say("GANA CPU");
					stats.fun += 40;
				end

			end

			break;

		end

		if ( !global_key_lock )

			// jugador humano
			if ( turn == 1 )
			
				// actualizo seleccion
				//unselect_all( &btn_selected );
				

				// agrego items
				if ( tabla[seleccion_x][seleccion_y] == 0 AND activated )

					global_key_lock = true;
					
					activated = false;

					piece( 90 + ( seleccion_x * 70 ), 50 + ( seleccion_y * 70 ), turn );

					tabla[seleccion_x][seleccion_y] = turn;

					empty--;

					check_tateti = true;

					turn = 2;

				// si no se agrego item muevo cursor
				else
					
					// movimiento del cursor
					if ( jkeys_state[_JKEY_RIGHT] )
						global_key_lock = true;
						
						seleccion_x = (seleccion_x+1)%3;
						
					elseif (jkeys_state[_JKEY_LEFT] )
						global_key_lock = true;
						
						seleccion_x--;
						if ( seleccion_x<0 ) seleccion_x = 2; end
						
					elseif (jkeys_state[_JKEY_DOWN] )
						global_key_lock = true;
						
						seleccion_y = (seleccion_y+1)%3;
						
					elseif (jkeys_state[_JKEY_UP] )
						global_key_lock = true;
						seleccion_y--;
						
						if ( seleccion_y<0 ) seleccion_y = 2; end
						
					end
					
				end

			// cpu
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

				empty--;

				check_tateti = true;

				turn = 1;

			end

		end

		if ( check_tateti )

			check_tateti = false;

			game_result = check_tateti( &tabla );

			// si hay un ganador termino el juego
			if ( game_result )
				game_end = true;
			end

		end
		
		frame;
		
		// compruebo si hay algun boton activado
		for ( x=0; x<3; x++)
			for ( y=0; y<3; y++ )
				if ( btn_activated[x][y] )
					activated = true;
					seleccion_x = x;
					seleccion_y = y;
				end
			end
		end
			
		unselect_all( &btn_selected );
		btn_selected[seleccion_x][seleccion_y] = true;
		
	end

onexit

	unload_fpg (file);

end

/* ------------------------------------------------------------------------- */
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
				tateti_found = tabla[(i*3) + 0];
			end

		end

		// horizontales
		if ( tabla[(0*3) + i] + tabla[(1*3) + i] + tabla[(2*3) + i] >= 3  )	// compruebo si la linea esta completa

			// compruebo tateti
			if ( tabla[(0*3) + i] == tabla[(1*3) + i] AND tabla[(0*3) + i] == tabla[(2*3) + i] )
				say( "TATETI HORIZONTAL!!!" );
				tateti_found = tabla[(0*3) + i];
			end

		end

	end

	// diagonal
	if ( tabla[(1*3) + 1] )	// compruebo si se ocupo el centro

		if ( tabla[(0*3) + 0] == tabla[(1*3) + 1] AND tabla[(1*3) + 1] == tabla[(2*3) + 2] )
			say( "TATETI DIAGONAL!!!" );
			tateti_found = tabla[(0*3) + 0];
		end

		if ( tabla[(2*3) + 0] == tabla[(1*3) + 1] AND tabla[(1*3) + 1] == tabla[(0*3) + 2] )
			say( "TATETI DIAGONAL!!!" );
			tateti_found = tabla[(2*3) + 0];
		end

	end

	return tateti_found;

end

function unselect_all( int pointer table )

begin

	for ( x=0; x<3; x++)
		for ( y=0; y<3; y++ )
		
			table[(x * 3) + y] = false;
			
		end
	end

end

function check_button_activation( int pointer table )

begin

	for ( x=0; x<3; x++)
		for ( y=0; y<3; y++ )
		
			if (table[(x * 3) + y] )
				say( "return true" );
				return true;
			end
			
		end
	end
	
	return false;

end
