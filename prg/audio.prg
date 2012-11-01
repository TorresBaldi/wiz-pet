/* ------------------------------------------------------------------------- */
PROCESS audio_manager()

private

	int target_volume;

end

begin

	loop
	
		// cambio el volumen
		if ( key(_1) and data.volume > 0 )
			data.volume--;
		end
		if ( key(_2) and data.volume < 128 )
			data.volume++;
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
				current_volume++;
			else
				current_volume--;
			end
						
			set_song_volume( current_volume );
			set_channel_volume( -1, current_volume );
			say( "volume: " + current_volume + "/" + target_volume );
		
		end
	
		frame;
		
	end
	
onexit

	audio_manager();

end
