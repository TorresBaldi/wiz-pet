/* ------------------------------------------------------------------------- */
PROCESS game_loop()

PRIVATE

	int busy = false;

END

BEGIN

	// el proceso no se duerme a si mismo
	signal_action( S_SLEEP_TREE, S_IGN);

	//cargo recursos
	fpg_pet = load_fpg( "fpg/pet.fpg" );

	// inicializacion del juego
	mostrar_hud();
	mascota();
	botones();
	actions_manager();
	caca_manager();

	//dibujo el fondo
	put( fpg_bg, stats.location, 160, 120 );

	loop

		
		if ( !busy )
		
			// cada tick
			IF ( timer[0] >= tick * 100 )
				timer[0] -= tick * 100;
				calcular_ticks(1);
			END

			// vuelvo al menu principal
			IF ( jkeys_state[ _JKEY_MENU ] )
				global_key_lock = true;
				open_main_menu = true;
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

			if ( busy == 0 )

				//debug;
				//kill_cacas();
				signal(id, S_SLEEP_TREE );
				
				put( fpg_bg, 10, 160, 120 );

			end

			busy++;

		end

		// reactivo el juego al terminar la accion
		if ( busy AND !do_action )

			busy = 0;
			signal ( id, S_WAKEUP_TREE );
			
			put( fpg_bg, stats.location, 160, 120 );

			kill_cacas();
			caca_updated = true;

			//debug;

		end

		frame;

	end
	
ONEXIT

	unload_fpg( fpg_pet );

END
