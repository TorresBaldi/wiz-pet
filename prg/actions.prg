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
				
					action_play_tateti();
				
				end
			
			
				//
				//	MOVER
				//
				case ACTN_MOVE:
				
					action_move();
				
				end
			
			end
			
			do_action = false;
			
			say( "action done!" );
	
		end
	
		frame;
		
	end

end
