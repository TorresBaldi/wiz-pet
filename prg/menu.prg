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
	
	//cargo recursos
	fpg_system = load_fpg("fpg/system.fpg");
	fpg_bg = load_fpg("fpg/bg.fpg");
	fpg_menu = load_fpg("fpg/menu.fpg");
	
	// inicio la intro
	start_intro(intro_skippable);
	
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
			
			intro_transition();
			
			// llamo al menu principal
			menu_option = main_menu();
			
			// espero a que se suelte el boton para seguir
			while ( jkeys_state[_JKEY_SELECT] or mouse.left )
				frame;
			end
			
			// llamo a la seccion del juego que corresponda
			switch ( menu_option )
			
				// salgo del juego
				case MENU_EXIT:
					do_exit();
				end
				
				case MENU_START:
				
					// inicio una nueva partida
					reset();
					
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

FUNCTION main_menu()

private
	
	int left_selected;
	int left_active;
	
	int right_selected;
	int right_active;
	
	int confirmed;
	int selection;
	
	int changed;

end

begin

	menu_avaliable[MENU_START] 		= 1;
	menu_avaliable[MENU_GRAVEYARD]	= 1;
	menu_avaliable[MENU_CREDITS]	= 1;
	menu_avaliable[MENU_EXIT]		= 1;
	menu_avaliable[MENU_OPTIONS]	= 1;
	menu_avaliable[MENU_CONTINUE]	= 1;

	put_Screen( fpg_bg, 10 );
	put( fpg_system, 125, 160, 160 );
	
	// creo los botones
	gui_button(30, 160, fpg_system, 100, &left_selected, &left_active);
	gui_button(290, 160, fpg_system, 110, &right_selected, &right_active);
	
	menu_logo();
	menu_central_button( &selection, &changed, &confirmed );

	loop
	
		global_key_lock();
		
		if ( !confirmed )
		
			if ( (!global_key_lock AND jkeys_state[_JKEY_LEFT]) OR left_active )

				global_key_lock = true;
				
				changed = true;
				
				// elijo la anterior opcion disponible
				REPEAT
					selection--;
					if ( selection < 0 ) selection = MENU_COUNT-1; end
				UNTIL ( menu_avaliable[selection] )

				say(selection);
				
			elseif ( (!global_key_lock AND jkeys_state[_JKEY_RIGHT]) OR right_active )

				global_key_lock = true;
				
				changed = true;
				
				// elijo la proxima opcion disponible
				REPEAT
					selection++;
					if ( selection > MENU_COUNT-1 ) selection = 0; end
				UNTIL ( menu_avaliable[selection] )
				
				say(selection);

			end
		
		// confirmo la seleccion
		else
		
			say( selection );
			
			return selection;
		
		end
	
		frame;
		
	end
onexit

	signal( id, S_KILL_TREE );

end

process menu_logo()

begin

	file = fpg_menu;
	graph = 1;
	
	x = 160;
	y = 50;

	loop
	
		frame;
		
	end

end

process menu_central_button( int pointer selection, int pointer selection_change, int pointer active )

private

	int i;
	
	int old_graphic;
	
	int busy;
	int do_animation;
	int doing_animation;
	
	int activation;

end

begin
	
	file = fpg_menu;
	
	graph = 100 + (*selection) * 10;
	
	x = 160;
	y = 160;

	loop
	
		*active = false;
	
		IF ( (collision ( type mouse ) and mouse.left) OR jkeys_state[ _JKEY_SELECT ] )
			activation++;
			if ( activation == 1 ) *active = true; end
		END
			
	
		if ( *selection_change )
		
			*selection_change = false;
			say("seleccion cambiada!");
			
			do_animation = true;
			doing_animation = false;
			
			if ( busy )
				busy = false;
			end
			
		end
		
		if ( do_animation and !busy )
			do_animation = false;
			busy = true;
		end
		
		if ( busy )
		
			if ( !doing_animation )
				size_x -= 10;
				if ( size_x <= 0 )
					doing_animation = true;
					graph = 100 + (*selection) * 10;
				end
			else
				size_x += 10;
				if ( size_x >= 100 ) busy = false; end
			end
		end
	
		frame;
		
	end

end
