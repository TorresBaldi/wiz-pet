/* ------------------------------------------------------------------------- */
process actions_manager()

PRIVATE

	int action_result;

END

begin

	// game_loop no duerme al proceso
	signal_action( S_SLEEP_TREE, S_IGN);

	loop

		if ( do_action )
		
			//put( fpg_bg, 10, 160, 120 );
			intro_transition(transition_speed);

			switch ( do_action )

				/* ------------------------------------------------------------------------- */
				case ACTN_FOOD:

					action_result = action_food();
					
					if ( action_result )
						action_alert( ALE_GOOD );
					else
						action_alert( ALE_BAD );
					end

				end

				/* ------------------------------------------------------------------------- */
				case ACTN_PLAY:
				
					// juega distintos juegos adentro y afuera
					if ( data.location == LOC_OUTSIDE )
					
						action_alert( ALE_GOINSIDE );
						
					else
					
						action_result = action_play_tateti();
						action_alert( action_result );
						
					end

				end

				/* ------------------------------------------------------------------------- */
				case ACTN_MOVE:

					action_move();

				end

				/* ------------------------------------------------------------------------- */
				case ACTN_HEAL:
				
					action_result = action_heal();
					action_alert( action_result );

				end
				
				/* ------------------------------------------------------------------------- */
				case ACTN_CLEAN:
				
					
				
					action_result = action_sweep();
					
					action_alert( action_result );

				end
				
				/* ------------------------------------------------------------------------- */
				case ACTN_BATH:

					// lo baño solo estando adentro y sucio
					if ( data.location == LOC_INSIDE and data.shower < 95 )
					
						action_bath();
						
					else
					
						if ( data.shower > 95 )
							action_alert( ALE_NOTNEED );
						else
							action_alert( ALE_GOINSIDE );
						end
						//action_nobath();
					end

				end

				/* ------------------------------------------------------------------------- */
				case ACTN_INFO:
				
					action_info();

				end
				
				/* ------------------------------------------------------------------------- */
				case ACTN_DIE:

					action_die();

				end

			end

			// espero a que se suelten los botones antes de reanudar el juego
			while ( global_key_lock )
				global_key_lock();
				frame;
			end
			
			intro_transition(transition_speed);
			
			do_action = false;
			
			update_mood();

		end

		frame;

	end

end

function action_alert( int graph );

begin

	file = fpg_system;
	
	x = 160;
	y = 120;
	
	size = 50;
	
	// espero a que suelte el boton
	while ( jkeys_state[_JKEY_SELECT] OR mouse.left )
		frame;
	end
	
	while ( !jkeys_state[_JKEY_SELECT] AND !mouse.left )
		
		if ( size < 100 )
			size += 10;
		end	
	
		frame;
		
	end
	
	// espero a que suelte el boton
	while ( jkeys_state[_JKEY_SELECT] OR mouse.left )
		frame;
	end


end
