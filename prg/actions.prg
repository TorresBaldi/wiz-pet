/* ------------------------------------------------------------------------- */
process actions_manager()

begin

	priority = 100;

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
				//	COMEr
				//
				case ACTN_FOOD:
				
					action_food();
				
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

process screen_transition()

begin

	file = 0;
	
	x = 160;
	y = 120;
	
	graph = screen_get();
	
	action_transition = true;
	
	// game_loop no duerme al proceso
	signal_action( S_SLEEP_TREE, S_IGN);
	
	loop
	
		alpha -= 8;
		
		if ( alpha <= 0 ) break; end
	
		frame;
		
	end
	
	action_transition = false;

end
