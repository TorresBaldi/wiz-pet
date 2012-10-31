/* ------------------------------------------------------------------------- */
function action_play_tateti()

private

	int i;
	int j;

	tabla[2][2];
	
	btn_selected[2][2];
	btn_activated[2][2];
	
	int activated;
	
	int button_graph;

	int seleccion_x;
	int seleccion_y;

	int empty = 9;

	int turn;

	int check_tateti;

	int game_result;
	int game_end;

end

begin

	turn = rand(1,2);

	fpg_tateti = load_fpg( "fpg/tateti.fpg" );
	
	file = fpg_tateti;
	
	graph = 1;
	
	z = 100;

	while ( jkeys_state[_JKEY_SELECT] or mouse.left )
		frame;
	end
	
	btn_selected[0][0] = true;
	
	for ( i=0; i<3; i++ )
		for ( j=0; j<3; j++ )
		
			// alterno los colores
			if ( (i%2 + j%2) == 1 )
				button_graph = 200;
			else
				button_graph = 202;
			end
			
			// creo los botones
			gui_button( 90 + ( i * 70), 50 + (j * 70), fpg_tateti, button_graph, &btn_selected[i][j], &btn_activated[i][j] );
			
			//saj( i + ", "+ j + ": " + graph );
			
		end
	end
	

	loop

		global_key_lock();

		// fin del juego
		if ( empty==0 OR game_end )

			switch (game_result)

				case 0:
					// say("EMPATE");
					stats.fun += 5;
				end

				case 1:
					// say("GANA JUGADOR");
					stats.fun += 30;
				end

				case 2:
					// say("GANA CPU");
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
		
		
		x = 160;
		y = 120;
		
		frame;
		
		// compruebo si hay algun boton activado
		for ( i=0; i<3; i++)
			for ( j=0; j<3; j++ )
				if ( btn_activated[i][j] )
					activated = true;
					seleccion_x = i;
					seleccion_y = j;
				end
			end
		end
			
		unselect_all( &btn_selected );
		btn_selected[seleccion_x][seleccion_y] = true;
		
	end

onexit

	unload_fpg (file);
	signal(id, S_KILL_TREE);

end

/* ------------------------------------------------------------------------- */
process piece(x,y,turn)

begin

	file = father.file;
	z = father.z - 200;
	graph = turn+1;

	loop
		frame;
	end

end

function int check_tateti( int pointer tabla )

private

	int tateti_found;
	int i;

end

begin

	// compruebo coincidencias
	for ( i=0; i<3; i++ )

		// verticales
		if ( tabla[(i*3) + 0] + tabla[(i*3) + 0] + tabla[(i*3) + 0] >= 3  )	// compruebo si la linea esta completa

			// compruebo tateti
			if ( tabla[(i*3) + 0] == tabla[(i*3) + 1] AND tabla[(i*3) + 0] == tabla[(i*3) + 2] )
				// say( "TATETI VERTICAL!!!" );
				tateti_found = tabla[(i*3) + 0];
			end

		end

		// horizontales
		if ( tabla[(0*3) + i] + tabla[(1*3) + i] + tabla[(2*3) + i] >= 3  )	// compruebo si la linea esta completa

			// compruebo tateti
			if ( tabla[(0*3) + i] == tabla[(1*3) + i] AND tabla[(0*3) + i] == tabla[(2*3) + i] )
				// say( "TATETI HORIZONTAL!!!" );
				tateti_found = tabla[(0*3) + i];
			end

		end

	end

	// diagonal
	if ( tabla[(1*3) + 1] )	// compruebo si se ocupo el centro

		if ( tabla[(0*3) + 0] == tabla[(1*3) + 1] AND tabla[(1*3) + 1] == tabla[(2*3) + 2] )
			// say( "TATETI DIAGONAL!!!" );
			tateti_found = tabla[(0*3) + 0];
		end

		if ( tabla[(2*3) + 0] == tabla[(1*3) + 1] AND tabla[(1*3) + 1] == tabla[(0*3) + 2] )
			// say( "TATETI DIAGONAL!!!" );
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
