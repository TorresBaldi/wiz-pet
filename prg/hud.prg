/* ------------------------------------------------------------------------- */
process mostrar_hud()

private

	int txt_id[10];

	int i;

	int show = false;

end

begin

	write_var(0,0,0,0,fps);

	write_var(0,screen_X,0,2,timer[0]);

	// muestro las barras
	hud_show_hbar( 36 + 000, 232, &stats.food );
	hud_show_hbar( 36 + 050, 232, &stats.fun );
	hud_show_hbar( 36 + 100, 232, &stats.health );
	hud_show_hbar( 36 + 150, 232, &stats.clean );
	hud_show_hbar( 36 + 200, 232, &stats.shower );
	hud_show_hbar( 36 + 250, 232, &stats.sleep );

	loop

		if ( show )
			txt_id[0] = write( 0, 0, 20, 3, (stats.food) + " hambre" );
			txt_id[1] = write( 0, 0, 30, 3, (stats.health) + " salud" );
			txt_id[2] = write( 0, 0, 40, 3, (stats.fun) + " diversion" );
			txt_id[3] = write( 0, 0, 50, 3, (stats.clean) + " limpieza" );
			txt_id[3] = write( 0, 0, 60, 3, (stats.shower) + " ducha" );
			txt_id[4] = write( 0, 0, 70, 3, (stats.sleep) + " energia" );
			txt_id[5] = write( 0, 0, 80, 3, (stats.age) + " edad" );
			txt_id[6] = write( 0, 0, 90, 3, (stats.ticks) + " ticks" );
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
