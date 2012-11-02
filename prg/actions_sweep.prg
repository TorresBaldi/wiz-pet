/* ------------------------------------------------------------------------- */
function action_sweep()

begin

	// uso X como contador de cacas
	for ( x=0; x <= 5; x++ )
		if ( data.dump[ data.location-1 ][x][0] )
			y++;
		end
	end
	
	if ( y > 0 )
	
		clean_caca( data.location );
		return ALE_CLEAN;
		
	else
	
		return ALE_NOTNEED;
		
	end

end
