import "mod_draw";

/* ------------------------------------------------------------------------- */
process botones()

private

	int i;
	int j;

	int select[BTN_COUNT];
	int active[BTN_COUNT];
	
	int button_move;

end

begin

	select[i] = true;

	gui_button(36 + 000, 225, fpg_hud, 10, &select[BTN_FOOD], &active[BTN_FOOD] );
	gui_button(36 + 050, 225, fpg_hud, 20, &select[BTN_PLAY], &active[BTN_PLAY] );
	gui_button(36 + 100, 225, fpg_hud, 30, &select[BTN_HEAL], &active[BTN_HEAL] );
	gui_button(36 + 150, 225, fpg_hud, 40, &select[BTN_CLEAN], &active[BTN_CLEAN] );
	gui_button(36 + 200, 225, fpg_hud, 50, &select[BTN_SHOWER], &active[BTN_SHOWER] );
	gui_button(36 + 250, 225, fpg_hud, 60, &select[BTN_SLEEP], &active[BTN_SLEEP] );

	// invierto la condicion
	if ( stats.location == LOC_OUTSIDE )
		button_move = gui_button(286, 126, fpg_hud, 100, &select[BTN_MOVE], &active[BTN_MOVE] );
	else
		button_move = gui_button(35, 126, fpg_hud, 200, &select[BTN_MOVE], &active[BTN_MOVE] );
	end

	loop

		// selecciono los distintos botones
		if ( jkeys_state[_JKEY_RIGHT] and !global_key_lock )

			global_key_lock = true;

			select[i] = false;

			i = (i+1) % BTN_COUNT;

			select[i] = true;

		elseif ( jkeys_state[_JKEY_LEFT] and !global_key_lock )

			global_key_lock = true;

			select[i] = false;

			i = (i-1) % BTN_COUNT;
			if (i<0) i= BTN_COUNT-1; end

			select[i] = true;

		end

		// acciones de los botones
		IF ( active[BTN_FOOD] )

			//
			//	COMER
			//
			do_action = ACTN_FOOD;

		ELSEIF ( active[BTN_PLAY] )

			//
			//	JUGAR
			//
			do_action = ACTN_PLAY;

		ELSEIF ( active[BTN_MOVE] )

			//
			//	SALIR / ENTRAR
			//
			
			// vuelvo a crear el boton de mover
			
			button_move.alpha = -20;
			
			if ( stats.location == LOC_INSIDE )
			
				// dibujo la puerta dentro para salir
				button_move = gui_button(286, 126, fpg_hud, 100, &select[BTN_MOVE], &active[BTN_MOVE] );
			
			else
			
				// dibujo la puerta afuera para entrar
				button_move = gui_button(35, 126, fpg_hud, 200, &select[BTN_MOVE], &active[BTN_MOVE] );
				
			end
			
			do_action = ACTN_MOVE;
			

		ELSEIF ( active[BTN_HEAL] )

			//
			//	MEDICINA
			//
			do_action = ACTN_HEAL;

		ELSEIF ( active[BTN_CLEAN] )

			//
			//	LIMPIAR / BARRER
			//
			//stats.sleep += 20;
			clean_caca( stats.location );

		ELSEIF ( active[BTN_SHOWER] )

			//
			//	BAÑAR
			//
			//stats.shower += 20;
			do_action = ACTN_SHOWER;

		ELSEIF ( active[BTN_SLEEP] )

			//
			//	DORMIR
			//
			stats.sleep += 20;

		END

		frame;

	end

end

/* ------------------------------------------------------------------------- */
function int draw_bar( int value, width, height )

private

	//int width = 30;
	//int height = 8;

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
process gui_button( int x, int y, int file, int button_graph, int pointer selected_flag, int pointer active_flag )

private

	state = 0;
	last_state = 0;

	activated = false;

end

begin

	loop

		// compruebo si el padre sigue vivo
		// mato de emergencia
		if ( !exists(father) or alpha<0 )
			break;
		end

		// compruebo si se selecciono desde afuera
		if ( *selected_flag )
			state = 1;
		end

		// compruebo si se presiono con el dedo
		if ( collision ( type mouse ) and mouse.left )
			state = 2;
		end

		// activo el boton
		if ( (state == 1 and jkeys_state[ _JKEY_SELECT ]) OR state == 2 )

			global_key_lock = true;
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
		graph = button_graph;
		if ( state ) graph++; end

		frame;

		last_state = state;
		state = 0;

	end

end
