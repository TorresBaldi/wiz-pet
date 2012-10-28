/* ------------------------------------------------------------------------- */
PROCESS game_loop()

PRIVATE

	int busy = false;

END

BEGIN

	// el proceso no se duerme a si mismo
	signal_action( S_SLEEP_TREE, S_IGN);

	// inicializacion del juego
	//mostrar_hud();
	mascota();
	botones();
	actions_manager();
	
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
