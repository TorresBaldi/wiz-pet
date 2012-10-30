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
				case ACTN_SHOWER:

					action_bath();

				end

			end

			//global_key_lock();
			while ( global_key_lock )
				global_key_lock();
				frame;
			end

			do_action = false;

			say( "action done!" );

		end

		frame;

	end

end
