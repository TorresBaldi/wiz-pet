process mostrar_hud()

private

	int txt_id[10];
	
	int i;

end

begin
	
	write_var(0,0,0,0,fps);
	
	write_var(0,screen_X,0,2,timer[0]);

	loop
	
		txt_id[0] = write( 0, 0, 20, 0, (stats.hambre / 10) + " hambre" );
		txt_id[1] = write( 0, 0, 30, 0, (stats.salud / 10) + " salud" );
		txt_id[2] = write( 0, 0, 40, 0, (stats.diversion / 10) + " diversion" );
		txt_id[3] = write( 0, 0, 50, 0, (stats.higiene / 10) + " higiene" );
		txt_id[4] = write( 0, 0, 60, 0, (stats.energia / 10) + " energia" );
		txt_id[5] = write( 0, 0, 70, 0, (stats.edad) + " edad" );
		txt_id[6] = write( 0, 0, 80, 0, (stats.ticks) + " ticks" );
		
		frame;
		
		for ( i=0; i<10; i++ )
			if ( txt_id[i] )
				delete_text( txt_id[ i ] );
				txt_id[i] = 0;
			end
		end
		
	end

end
