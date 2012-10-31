/* ------------------------------------------------------------------------- */
PROCESS game_controller()

PRIVATE

	int i;
	
END

BEGIN
	// al terminar el menu inicio el juego
	game_loop();

	LOOP
	
		
	
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

	fpg_menu = load_fpg("fpg/menu.fpg");

	put_Screen( fpg_bg, 10 );
	put( fpg_system, 125, 160, 160 );
	
	// creo los botones
	gui_button(30, 160, fpg_system, 100, &left_selected, &left_active);
	gui_button(290, 160, fpg_system, 110, &right_selected, &right_active);
	
	menu_logo();
	menu_central_button( &selection, &changed );

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

			// confirmacion de la comida
			if ( (!global_key_lock AND jkeys_state[_JKEY_SELECT]) OR 0 )

				global_key_lock = true;
				confirmed = true;

			end
		
		// confirmo la seleccion
		else
		
			say( selection );
			break;
		
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

process menu_central_button( int pointer selection, int pointer selection_change )

private

	int i;
	
	int old_graphic;
	
	int busy;
	int do_animation;
	int doing_animation;
	
	int speed;

end

begin
	
	file = fpg_menu;
	
	graph = 100 + (*selection) * 10;
	
	x = 160;
	y = 160;

	loop
	
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
