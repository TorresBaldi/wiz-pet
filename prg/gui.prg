import "mod_draw";
/* ------------------------------------------------------------------------- */

GLOBAL

	int boton_comer_activado;
	int boton_curar_activado;
	
	int boton_comer_seleccionado;
	int boton_curar_seleccionado;
	
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

	boton_comer_seleccionado = true;

	gui_button(40, 180, 0, &select[0], &active[0] );
	gui_button(120, 180, 0, &select[1], &active[1] );
	gui_button(200, 180, 0, &select[2], &active[2] );
	gui_button(280, 180, 0, &select[3], &active[3] );

	loop
	
		if ( (key( _left ) or key(_right) ) and !key_lock )
		
			key_lock = true;
			
			select[i] = false;
			i = (i+1) % 4;
			select[i] = true;
			
		end
		
		if ( !key(_left) and !key(_right) )
			key_lock = false;
		end
		
		for( j=0; j<4; j++ )
			
			if ( active[j] )
				say( J + " ACTIVE" );
			end
			
		end
	
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
		if ( collision ( type mouse ) )
			state = 2;
		end
		
		// activo el boton
		if ( state == 2 and mouse.left )
			activated++;
		elseif ( state == 1 and key(_enter) )
			activated++;
		end
		
		//desactivo el boton
		if ( !mouse.left and not key(_enter) )
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
