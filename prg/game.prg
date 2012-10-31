/* ------------------------------------------------------------------------- */
PROCESS game_controller()

PRIVATE

	int i;
	
	int menu_option;
	
	int intro_skippable;
	
END

BEGIN

	// inicializacion
	jkeys_set_default_keys();
	jkeys_init();
	
	// si encuentro archivo indico que se puede saltar la intro
	intro_skippable = load_data();
	
	// establezco opciones disponibles en menu
	if ( intro_skippable )
		menu_avaliable[MENU_START] = FALSE;
		menu_avaliable[MENU_CONTINUE] = TRUE;
	else
		menu_avaliable[MENU_START] = TRUE;
		menu_avaliable[MENU_CONTINUE] = FALSE;
	end
	menu_avaliable[MENU_EXIT] = TRUE;
	
	//cargo recursos
	fpg_system = load_fpg("fpg/system.fpg");
	fpg_bg = load_fpg("fpg/bg.fpg");
	fpg_menu = load_fpg("fpg/menu.fpg");
	
	//inicio la musica
	ogg_dst_dreamingreen = load_song( "audio/dst-dreamingreen.ogg" );
	play_song( ogg_dst_dreamingreen, 0 );
	
	// inicio la intro
	start_intro(intro_skippable);
	
	intro_skippable = 1;
	
	LOOP
	
		global_key_lock();
		
		IF ( EXIT_STATUS )
			do_exit();
		END
	
		if ( open_main_menu AND !global_key_lock )
		
			open_main_menu = false;
		
			// elimino todo en el juego
			let_me_alone();
			delete_text(ALL_TEXT);
			clear_screen();
			
			say("let_me_alone");
			
			// si vengo de la intro, hago el efecto lento
			if ( intro_skippable )
			
				intro_skippable = false;
				do_action = FALSE;	// evito la muerte repentina
				stats.status = STA_NORMAL;
				
				intro_transition(5);
			else
			
				// todas las demas veces el efecto normal
				intro_transition(12);
			end
			
			// llamo al menu principal
			menu_option = main_menu();
			
			// espero a que se suelte el boton para seguir
			while ( jkeys_state[_JKEY_SELECT] or mouse.left )
				frame;
			end
			
			intro_transition(12);
			
			clear_screen();

			timer[0] = tick * 100;
			
			// llamo a la seccion del juego que corresponda
			switch ( menu_option )
			
				// salgo del juego
				case MENU_EXIT:
					do_exit();
				end
				
				case MENU_START:
				
					// inicio una nueva partida
					reset();
					
					// habilito la opcion de continuar la partida
					menu_avaliable[MENU_CONTINUE] = TRUE;
					
					game_loop();
				
				end
				
				case MENU_CONTINUE:
				
					game_loop();					
					
				end
				
				default:
				
					// espero a que se suelte el boton para seguir
					while ( jkeys_state[_JKEY_SELECT] or mouse.left )
						frame;
					end
					
					open_main_menu = true;
					
				end
			
			end
			
		end
			
		frame;
		
	END

END

/* ------------------------------------------------------------------------- */
PROCESS game_loop()

PRIVATE

	int busy;

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
	caca_manager();	
	actions_manager();

	//dibujo el fondo
	put( fpg_bg, stats.location, 160, 120 );
	
	//bajo el volumen de la musica
	set_song_volume(48);

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
		if ( do_action )


			busy++;

			if ( busy == 1 )
			
				signal(id, S_SLEEP_TREE );
				say( "inicio accion" );

			end


		end

		// reactivo el juego al terminar la accion
		if ( busy AND !do_action )

			busy = 0;
			signal ( id, S_WAKEUP_TREE );
			
			put_screen( fpg_bg, stats.location);

			kill_cacas();
			
			caca_updated = true;

			//debug;

		end

		frame;

	end
	
ONEXIT

	unload_fpg( fpg_pet );
	
	//subo el volumen de la musica
	set_song_volume(128);
END
