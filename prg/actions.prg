/* ------------------------------------------------------------------------- */
process actions_manager()

begin

	// game_loop no duerme al proceso
	signal_action( S_SLEEP_TREE, S_IGN);

	loop
	
		if ( do_action )
		
			switch ( do_action )
			
				//
				//	JUGAR
				//
				case ACTN_PLAY:
				
					play_tateti();
				
				end
			
			end
			
			do_action = false;
	
		end
	
		frame;
		
	end

end
