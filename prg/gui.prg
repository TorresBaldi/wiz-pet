import "mod_draw";
/* ------------------------------------------------------------------------- */

CONST

	BTN_FOOD 	= 0;
	BTN_MED 	= 1;
	BTN_PLAY 	= 2;
	BTN_BATH 	= 3;
	BTN_SLEEP 	= 4;

END

GLOBAL
	
	int i;
	int select[4];
	int active[4];
	
	int j;

END

/* ------------------------------------------------------------------------- */
process botones() 

private

	int key_lock;
	
end

begin

	select[i] = true;

	gui_button(64 -32, 208, 0, &select[0], &active[0] );
	gui_button(128 -32, 208, 0, &select[1], &active[1] );
	gui_button(192 -32, 208, 0, &select[2], &active[2] );
	gui_button(256 -32, 208, 0, &select[3], &active[3] );
	gui_button(320 -32, 208, 0, &select[4], &active[4] );

	loop
	
		// selecciono los distintos botones
		if ( jkeys_state[_JKEY_RIGHT] and !key_lock )
		
			key_lock = true;
			
			select[i] = false;
			
			i = (i+1) % 5;
			
			select[i] = true;
			
		elseif ( jkeys_state[_JKEY_LEFT] and !key_lock )
		
			key_lock = true;
			
			select[i] = false;
			
			i = (i-1) % 5;
			if (i<0) i= 4; end
			
			select[i] = true;
			
		end
		
		if ( !jkeys_state[_JKEY_LEFT] AND !jkeys_state[_JKEY_RIGHT] )
			key_lock = false;
		end
		
		for( j=0; j<4; j++ )
			
			if ( active[j] )
				say( J + " ACTIVE" );
			end
			
		end

		// acciones de los botones
		IF ( active[BTN_FOOD] )
		
			stats.hambre += 20;
			
		ELSEIF ( active[BTN_MED] )
		
			stats.salud += 20;
			
		ELSEIF ( active[BTN_PLAY] )
		
			stats.diversion += 20;
			
		ELSEIF ( active[BTN_BATH] )
		
			stats.higiene += 20;
			
		ELSEIF ( active[BTN_SLEEP] )
		
			stats.energia += 20;
			
		END
	
		frame;
		
	end

end

/* ------------------------------------------------------------------------- */
function int draw_bar( int value )

private

	int width = 100;
	int height = 8;
	
	int width_value;
	
	int map_id;

end

begin

	map_id = map_new( width, height, SCREEN_D);
	
	drawing_map ( 0, map_id );
	
	width_value = (width * value) / 100;
	
	draw_line ( 1, 0, width - 2, 0 );
	draw_line ( 1, height-1, width - 2, height-1 );
	
	draw_line ( 0, 1, 0, height - 2 );
	draw_line ( width-1, 1, width-1, height - 2 );
	
	if ( value > 0 )
		draw_box ( 1, 1, 1+width_value, height-2 );
	end
	
	return map_id;

end

/* ------------------------------------------------------------------------- */
// boton que se puede activar de forma tactil, o al seleccionarlo desde afuera
process gui_button( int x, int y, int icon, int pointer selected_flag, int pointer active_flag )

private

	state = 0;
	last_state = 0;
	
	activated = false;

end

begin

	file = load_fpg("fpg/system.fpg");
	graph = 10;

	loop
	
		// compruebo si se selecciono desde afuera
		if ( *selected_flag )
			state = 1;
		end
		
		// compruebo si se presiono con el dedo
		if ( collision ( type mouse ) and mouse.left )
			state = 2;
		end
		
		// activo el boton
		if ( state == 2 )
			activated++;
		elseif ( state == 1 and jkeys_state[ _JKEY_SELECT ] )
			activated++;
		end
		
		//desactivo el boton
		if ( !mouse.left and not jkeys_state[ _JKEY_SELECT ] )
			activated = 0;
		end
		
		if ( activated == 1 )
			*active_flag = 1;
		else
			*active_flag = 0;
		end	
			
		// actualizo el grafico
		graph = 10 + state;
	
		frame;
		
		last_state = state;
		state = 0;
		
	end

end
