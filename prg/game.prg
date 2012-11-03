/* ------------------------------------------------------------------------- */
PROCESS game_controller()

PRIVATE
	
	int menu_option;
	
	int data_loaded;
	
	int first_run = true;
	
END

BEGIN

	// inicializacion
	jkeys_set_default_keys();
	jkeys_init();
	
	audio_manager();
	
	// si encuentro archivo indico que se puede saltar la intro
	data_loaded = load_data();
	
	//say( "data_loaded:" + data_loaded );
	
	// establezco opciones disponibles en menu principal
	menu_avaliable[MENU_START] = TRUE;
	menu_avaliable[MENU_CREDITS] = TRUE;
	menu_avaliable[MENU_EXIT] = TRUE;
	
	IF ( data_loaded )
		menu_avaliable[MENU_CONTINUE] = TRUE;
	END
	
	IF ( data.graveyard[0].age )
		menu_avaliable[MENU_GRAVEYARD] = TRUE;
	END
	
	// establezco duraciones de las edades
	age_duration[AGE_BABY]	= 1 * TICKS_PER_DAY;
	age_duration[AGE_CHILD]	= 2 * TICKS_PER_DAY;
	age_duration[AGE_TEEN]	= 4 * TICKS_PER_DAY;
	age_duration[AGE_ADULT]	= 7 * TICKS_PER_DAY;
	age_duration[AGE_OLD]	= 10 * TICKS_PER_DAY;
	
	//cargo recursos
	fpg_system = load_fpg("fpg/system.fpg");
	fpg_hud = load_fpg("fpg/hud.fpg");
	fpg_bg = load_fpg("fpg/bg.fpg");
	fpg_menu = load_fpg("fpg/menu.fpg");
	
	fnt_nueva_18 = load_fnt("fnt/nueva-std-bold-18.fnt");
	
	wav_fart = load_wav( "audio/fart.wav" );
	
	//inicio la musica
	ogg_dst_dreamingreen = load_song( "audio/dst-dreamingreen.ogg" );
	play_song( ogg_dst_dreamingreen, -1 );
	
	// inicio la intro
	//start_intro(1);
	start_intro(data_loaded);
	
	frame;
	
	if ( OS_ID <> OS_GP2X_WIZ )
		mouse.file = fpg_system;
		mouse.graph = 1;
	end
	
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
			
			// say("let_me_alone");
			
			// si vengo de la intro, hago el efecto lento
			if ( first_run )
			
				first_run = false;
				do_action = FALSE;	// evito la muerte repentina
				data.status = STA_NORMAL;
				
				intro_transition(5);
			else
			
				// todas las demas veces el efecto normal
				intro_transition(transition_speed);
			end
			
			// llamo al menu principal
			menu_option = main_menu();
			
			// espero a que se suelte el boton para seguir
			while ( jkeys_state[_JKEY_SELECT] or mouse.left )
				frame;
			end
			
			intro_transition(transition_speed);
			
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
					//reset();
					game_start_new();
					
					game_loop();
				
				end
				
				case MENU_CONTINUE:
				
					game_loop();					
					
				end
				
				case MENU_CREDITS:
				
					show_credits();					
					
				end
				
				case MENU_GRAVEYARD:
				
					show_graveyard();					
					
				end
				
				default:
				
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
	
	int i;
	int width;
	int height;

END

BEGIN

	// el proceso no se duerme a si mismo
	signal_action( S_SLEEP_TREE, S_IGN);

	//cargo recursos
	fpg_pet = load_fpg( "fpg/pet.fpg" );
	
	// pongo los puntos de control en los pies de la mascota
	for( i=0; i<999; i++)
	
		if ( map_exists(fpg_pet, i) )
			width = graphic_info(fpg_pet, i, G_WIDTH );
			height = graphic_info(fpg_pet, i, G_HEIGHT );
			set_center( fpg_pet, i, width/2, height );
		end
	
	end

	// inicializacion del juego	
	mostrar_hud();
	botones();
	caca_manager();	
	mascota();
	actions_manager();

	//dibujo el fondo
	put_screen( fpg_bg, data.location );
	
	//bajo el volumen de la musica
	set_song_volume(48);
	
	// indico que se inicio una partida
	game_started = true;

	loop

		
		if ( !busy )
		
			// cada tick
			IF ( timer[0] > tick * 100 )
			
				timer[0] -= tick * 100;
				calcular_ticks( 1, TICK_INGAME );
				
			END

			// vuelvo al menu principal
			IF ( jkeys_state[ _JKEY_MENU ] )
			
				global_key_lock = true;
				open_main_menu = true;
				
			END
			
			/*
			//debug
			if ( jkeys_state[ _JKEY_R ] )
			
				calcular_ticks( 1, TICK_INGAME );
				
			end
			if ( jkeys_state[ _JKEY_L ] )
				reset();
			end
			*/
		end


		// al activar una accion, duermo el juego
		if ( do_action )


			busy++;

			if ( busy == 1 )
			
				signal(id, S_SLEEP_TREE );
				// say( "inicio accion" );

			end


		end

		// reactivo el juego al terminar la accion
		if ( busy AND !do_action )

			busy = 0;
			
			update_mood();
			
			put_screen( fpg_bg, data.location);
			
			caca_updated = true;
			
			signal ( id, S_WAKEUP_TREE );

			//debug;

		end

		frame;

	end
	
ONEXIT

	// descargo recursos
	unload_fpg( fpg_pet );
	
	//subo el volumen de la musica
	set_song_volume(128);
	
	game_started = false;
END

// RESET
function game_start_new()

begin

	// say("GAME START NEW");

	data.food = 80;
	data.health = 80;
	data.fun = 80;
	data.clean = 80;
	data.shower = 80;

	data.ticks = 0;
	data.age = AGE_BABY;
	
	data.location = LOC_INSIDE;
	
	data.status = STA_NORMAL;

	clean_caca(0);
	clean_caca(1);

	data.first_time = time();
	data.last_time = time();
	
	menu_avaliable[MENU_CONTINUE] = TRUE;
	
	update_mood();
	
	// le pongo nombre
	data.name = wizkeyboard("fpg/keyboard.fpg", fnt_nueva_18, fnt_nueva_18, 0, "Name Your Pet!", 15);
	
	while( mouse.left OR jkeys_state[_JKEY_SELECT] )
		frame;
	end

end

