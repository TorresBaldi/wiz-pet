/* ------------------------------------------------------------------------- */
process actions_manager()

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

					action_food();

				end

				/* ------------------------------------------------------------------------- */
				case ACTN_PLAY:
				
					// juega distintos juegos adentro y afuera
					if ( data.location == LOC_OUTSIDE )
						action_play_ball();
					else
						action_play_tateti();
					end

				end

				/* ------------------------------------------------------------------------- */
				case ACTN_MOVE:

					action_move();

				end

				/* ------------------------------------------------------------------------- */
				case ACTN_HEAL:

					action_heal();

				end
				
				/* ------------------------------------------------------------------------- */
				case ACTN_CLEAN:
				
					action_sweep();

				end
				
				/* ------------------------------------------------------------------------- */
				case ACTN_BATH:

					// lo baño solo estando adentro y sucio
					if ( data.location == LOC_INSIDE and data.shower < 95 )
						action_bath();
					else
						action_nobath();
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
