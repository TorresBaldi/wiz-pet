/* ------------------------------------------------------------------------- */
FUNCTION main_menu()

private
	
	int left_selected;
	int left_active;
	
	int right_selected;
	int right_active;
	
	int confirmed;
	int selection;
	
	int changed;
	
	int txt_id;

end

begin

	put_Screen( fpg_bg, 10 );
	put( fpg_system, 125, 160, 160 );
	
	// elijo la primera opcion disponible
	WHILE ( !menu_avaliable[selection] )
		selection++;
	END


	// creo los botones
	gui_button(30, 160, fpg_system, 100, &left_selected, &left_active);
	gui_button(290, 160, fpg_system, 110, &right_selected, &right_active);
	
	menu_logo();
	menu_central_button( &selection, &changed, &confirmed );
	
	txt_id = write( 0, 320, 0, 2, ver );

	loop
	
		global_key_lock();
		
		if ( !confirmed )
		
			if ( !global_key_lock )
				left_selected = false;
				right_selected = false;
			end
			
		
			if ( (!global_key_lock AND jkeys_state[_JKEY_LEFT]) OR left_active )

				global_key_lock = true;
				
				left_selected = true;
				
				changed = true;
				
				// elijo la anterior opcion disponible
				REPEAT
					selection--;
					if ( selection < 0 ) selection = MENU_COUNT-1; end
				UNTIL ( menu_avaliable[selection] )

				// say(selection);
				
			elseif ( (!global_key_lock AND jkeys_state[_JKEY_RIGHT]) OR right_active )

				global_key_lock = true;
				
				right_selected = true;
				
				changed = true;
				
				// elijo la proxima opcion disponible
				REPEAT
					selection++;
					if ( selection > MENU_COUNT-1 ) selection = 0; end
				UNTIL ( menu_avaliable[selection] )
				
				// say(selection);
			
			// elijo la opcion salir
			elseif ( (!global_key_lock AND jkeys_state[_JKEY_MENU]) )
			
				global_key_lock = true;
				changed = true;
				selection = MENU_EXIT;
				
				// say("elijo salir");
			
			end
		
		// confirmo la seleccion
		else
		
			// say( selection );
			
			return selection;
		
		end
	
		frame;
		
	end
onexit

	delete_text( txt_id );
	
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
			// say("seleccion cambiada!");
			
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
				size_x -= 20;
				if ( size_x <= 0 )
					doing_animation = true;
					graph = 100 + (*selection) * 10;
				end
			else
				size_x += 20;
				if ( size_x >= 100 ) busy = false; end
			end
		end
	
		frame;
		
	end

end
