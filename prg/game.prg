/* ------------------------------------------------------------------------- */
PROCESS game_loop()

PRIVATE

	int busy = false;

END

BEGIN

	// el proceso no se duerme a si mismo
	signal_action( S_SLEEP_TREE, S_IGN);

	//cargo recursos
	fpg_bg 	= load_fpg( "fpg/bg.fpg" );	
	fpg_pet	= load_fpg( "fpg/pet.fpg" );

	// inicializacion del juego
	mostrar_hud();
	mascota();
	botones();
	actions_manager();
	caca_manager();

	//dibujo el fondo
	put( fpg_bg, stats.location, 160, 120 );
	
	loop
	
		// cada tick
		if ( !busy )
			IF ( timer[0] >= tick * 100 )
			
				timer[0] -= tick * 100;
				
				calcular_ticks(1);
			
			END
			
			//debug
			if ( jkeys_state[ _JKEY_R ] )
				calcular_ticks(1);
			end
			if ( jkeys_state[ _JKEY_L ] )
				reset();
			end
		end
		

		// al activar una accion, duermo el juego
		if ( do_action AND !busy )
		
			busy++;
			
			signal(id, S_SLEEP_TREE );
			
		end
		
		// reactivo el juego al terminar la accion
		if ( busy AND !do_action )
		
			busy = 0;
			signal ( id, S_WAKEUP_TREE );
			
		end
		
		frame;
	
	end

END

/* ------------------------------------------------------------------------- */
process caca_manager()

private
	int i;
	int caca_id;
	
	int l;
end

begin

	loop
	
		// actualizo si corresponde
		if ( caca_updated )
				
			caca_updated = false;
			l = stats.location - 1;
			say( "ACTUALIZO CACAS LOCATION: " + l );
			
			//elimino todas las cacas
			while ( caca_id = get_id(type caca) )
				//say("HAY CACA!");
				signal( caca_id, S_KILL );
			end
		
			//recorro la lista de cacas
			for ( i=0; i <= 5; i++ )
			
				// si se hizo caca
				if ( stats.dump[l][i][0] )
				
					// si no fue creada la crea
					if ( !stats.dump[l][i][3] )
						// creo [id] = caca( [x],[y] )
						stats.dump[l][i][3] = caca( stats.dump[l][i][1], stats.dump[l][i][2]);
					end
					
					// si no existe el proceso que figura
					if ( !exists(stats.dump[l][i][3]) )
						stats.dump[l][i][3] = caca( stats.dump[l][i][1], stats.dump[l][i][2]);
						//say( stats.dump[l][i][3].reserved.process_type );
					end
				
				// si la caca fue limpiada
				elseif ( !stats.dump[l][i][0] AND stats.dump[l][i][3] )
				
					// elimino la caca
					if ( exists(stats.dump[l][i][3]) )
						signal( stats.dump[l][i][3], S_KILL );
						stats.dump[l][i][3] = 0;
					end
				
				end
			
			end
		
		end
	
		frame;
		
	end

end

/* ------------------------------------------------------------------------- */
/*
	hace caca
*/
function do_caca()

private
	int i;
end

begin

	// busco un lugar vacio
	for( i=0; i <= 5; i++ )
	
		if ( stats.dump[ stats.location -1 ][i][0] == false )
			break;
		end
		
	end
	
	// si hay lugar vacio
	if ( i <= 5 )
	
		// creo la caca
		stats.dump[ stats.location -1 ][i][0] = true;
		stats.dump[ stats.location -1 ][i][1] = rand(20,100);
		stats.dump[ stats.location -1 ][i][2] = rand(20,100);
		
		caca_updated = true;
	
	end

end

/* ------------------------------------------------------------------------- */
process caca(x,y)

begin

	file = fpg_pet;
	graph = 1;

	loop
	
		frame;
		
	end

end
