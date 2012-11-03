/* ------------------------------------------------------------------------- */
PROCESS audio_manager()

private

	int target_volume;
	
	int volume_change;
	int volume_change_time;

end

begin

	x = 160;
	y = 5;
	z = -9990;

	loop
	
		// cambio el volumen
		if ( jkeys_state[ _JKEY_VOLDOWN ] and data.volume > 0 )
		
			data.volume -= 2;
			
			volume_change = true;
			volume_change_time = 0;
			
			
		end
		if ( jkeys_state[ _JKEY_VOLUP ] and data.volume < 128 )
		
			data.volume += 2;
			
			volume_change = true;
			volume_change_time = 0;
			
		end
	
		// si se cambio el volumen
		if ( game_started )
			target_volume = (data.volume/3) * 2;
		else
			target_volume = data.volume;
		end
		
		// pregunto si tengo que cambiar el volumen
		if ( current_volume <> target_volume )
		
			if ( current_volume < target_volume )
				current_volume+=2;
			else
				current_volume-=2;
			end
			
			// ajusto el volumen
			set_song_volume( current_volume );
			//set_channel_volume( -1, current_volume );
		
		end
		
		// muestro
		if ( volume_change )
		
			volume_change_time++;
			
			if ( volume_change_time > 20 ) volume_change = false; end
		
			graph = draw_bar( (data.volume * 100)/128, 50, 8 );
			
		else
		
			graph = 0;
		
		end
	
		frame;
		
	end
	
onexit

	audio_manager();

end
