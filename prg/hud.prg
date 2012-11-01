/* ------------------------------------------------------------------------- */
process mostrar_hud()

private

	int txt_id[10];

	int i;

	int show = false;

end

begin

	if ( show )

	write_var(0,0,0,0,fps);

	write_var(0,screen_X,0,2,timer[0]);
	
	// muestro las barras
	hud_show_hbar( 36 + 000, 232, &data.food );
	hud_show_hbar( 36 + 050, 232, &data.fun );
	hud_show_hbar( 36 + 100, 232, &data.health );
	hud_show_hbar( 36 + 150, 232, &data.clean );
	hud_show_hbar( 36 + 200, 232, &data.shower );
	
	end

	loop

		if ( show )
			txt_id[0] = write( 0, 0, 20, 3, (data.food) + " hambre" );
			txt_id[1] = write( 0, 0, 30, 3, (data.health) + " salud" );
			txt_id[2] = write( 0, 0, 40, 3, (data.fun) + " diversion" );
			txt_id[3] = write( 0, 0, 50, 3, (data.clean) + " limpieza" );
			txt_id[3] = write( 0, 0, 60, 3, (data.shower) + " ducha" );
			txt_id[4] = write( 0, 0, 80, 3, (data.age) + " edad" );
			txt_id[5] = write( 0, 0, 90, 3, (data.ticks) + " ticks" );
		end

		frame;

		for ( i=0; i<10; i++ )
			if ( txt_id[i] )
				delete_text( txt_id[ i ] );
				txt_id[i] = 0;
			end
		end

	end

end

process hud_show_hbar( int x, int y, float pointer value )

private

	int current_value;
	int last_value;

end

begin

	current_value = *value;
	graph = draw_bar( current_value, 30, 8 );

	loop

		current_value = *value;

		// actualizo el grafico
		if ( current_value <> last_value )

			map_unload( 0, graph );
			graph = draw_bar( current_value, 30, 8 );

		end

		frame;

		last_value = current_value;

	end

end
