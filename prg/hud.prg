/* ------------------------------------------------------------------------- */
process mostrar_hud()

private

	int txt_id[10];
	
	int i;

end

begin
	
	write_var(0,0,0,0,fps);
	
	write_var(0,screen_X,0,2,timer[0]);
	
	write(0,screen_X/2,screen_y,7, "[A] [S] [D] [F] [G] Cambiar Stats" );
	
	// muestro las barras
	hud_show_hbar( 100, 20, &stats.hambre );
	hud_show_hbar( 100, 30, &stats.salud );
	hud_show_hbar( 100, 40, &stats.diversion );
	hud_show_hbar( 100, 50, &stats.higiene );
	hud_show_hbar( 100, 60, &stats.energia );
	
	loop
	
		txt_id[0] = write( 0, 0, 20, 3, (stats.hambre) + " hambre" );
		txt_id[1] = write( 0, 0, 30, 3, (stats.salud) + " salud" );
		txt_id[2] = write( 0, 0, 40, 3, (stats.diversion) + " diversion" );
		txt_id[3] = write( 0, 0, 50, 3, (stats.higiene) + " higiene" );
		txt_id[4] = write( 0, 0, 60, 3, (stats.energia) + " energia" );
		txt_id[5] = write( 0, 0, 70, 3, (stats.edad) + " edad" );
		txt_id[6] = write( 0, 0, 80, 3, (stats.ticks) + " ticks" );
		
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
	graph = draw_bar( current_value );

	loop
	
		current_value = *value;
	
		// actualizo el grafico
		if ( current_value <> last_value )
		
			map_unload( 0, graph );
			graph = draw_bar( current_value );
			
		end
	
		frame;
		
		last_value = current_value;
		
	end

end
