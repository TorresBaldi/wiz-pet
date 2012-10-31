/* ------------------------------------------------------------------------- */
process actions_manager()

begin

	// game_loop no duerme al proceso
	signal_action( S_SLEEP_TREE, S_IGN);

	loop

		if ( do_action )
		
			//put( fpg_bg, 10, 160, 120 );
			intro_transition(12);

			switch ( do_action )

				//
				//	JUGAR
				//
				case ACTN_PLAY:
				
					action_play_tateti();

				end


				//
				//	COMER
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

				//
				//	CURAR
				//
				case ACTN_HEAL:

					action_heal();

				end

				//
				//	BAÑARSE
				//
				case ACTN_BATH:

					action_bath();

				end

				//
				//	NO PUEDE BAÑARSE AFUERA
				//
				case ACTN_NOBATH:

					action_no_bath();

				end

				//
				//	MORIR
				//
				case ACTN_DIE:

					action_die();

				end

			end

			//global_key_lock();
			// espero a que se suelten los botones antes de reanudar el juego
			while ( global_key_lock )
				global_key_lock();
				frame;
			end
			
			intro_transition(12);
			
			do_action = false;
			
			update_mood();

			//say( "action done!" );

		end

		frame;

	end

end
