/* ------------------------------------------------------------------------- */
process actions_manager()

begin

	priority = 100;

	// game_loop no duerme al proceso
	signal_action( S_SLEEP_TREE, S_IGN);

	loop
	
		if ( do_action )
		
			screen_transition();
		
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
			
			screen_transition();
	
		end
	
		frame;
		
	end

end

process screen_transition()

begin

	file = 0;
	
	x = 160;
	y = 120;
	
	graph = screen_get();
	
	action_transition = true;
	
	loop
	
		alpha -= 8;
		
		if ( alpha <= 0 ) break; end
	
		frame;
		
	end
	
	action_transition = false;

end
