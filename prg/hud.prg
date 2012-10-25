process mostrar_hud()

private

	int txt_id[5];

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
		
		frame;
		
		delete_text( txt_id[0] );
		delete_text( txt_id[1] );
		delete_text( txt_id[2] );
		delete_text( txt_id[3] );
		delete_text( txt_id[4] );
		
	end

end
