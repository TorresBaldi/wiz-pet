/* ------------------------------------------------------------------------- */
process caca_manager()

private
	int i;
	int caca_id;

	int l;
end

begin

	priority = 100;

	loop

		// actualizo si corresponde
		if ( caca_updated )

			caca_updated = false;
			l = stats.location - 1;

			//say( "ACTUALIZO CACAS LOCATION: " + l );

			//elimino todas las cacas
			while ( caca_id = get_id(type caca) )
				//say("HAY CACA!");
				signal( caca_id, S_KILL );
			end

			//recorro la lista de cacas
			for ( i=0; i <= 5; i++ )

				// si se hizo caca
				if ( stats.dump[l][i][0] )

					x = stats.dump[l][i][1];
					y = stats.dump[l][i][2];

					// si no fue creada la crea
					if ( !stats.dump[l][i][3] )

						// creo [id] = caca( [x],[y] )
						stats.dump[l][i][3] = caca( x, y);
						//say("creo caca nueva en " + x + "," + y);

					end

					// si no existe el proceso que figura
					if ( !exists(stats.dump[l][i][3]) )

						stats.dump[l][i][3] = caca( x, y);
						//say("creo caca muerta en " + x + "," + y);
						//say( stats.dump[l][i][3].reserved.process_type );

					end

				// si la caca fue limpiada
				elseif ( !stats.dump[l][i][0] AND stats.dump[l][i][3] )

					// elimino la caca
					if ( exists(stats.dump[l][i][3]) )
						signal( stats.dump[l][i][3], S_KILL );
						stats.dump[l][i][3] = 0;
					end

				end

			end

		end

		frame;

	end

end

/* ------------------------------------------------------------------------- */
/*
	hace caca
*/
function do_caca()

private
	int i;
end

begin

	// busco un lugar vacio
	for( i=0; i <= 5; i++ )

		if ( stats.dump[ stats.location -1 ][i][0] == false )
			break;
		end

	end

	// si hay lugar vacio
	if ( i <= 5 )

		// creo la caca
		stats.dump[ stats.location -1 ][i][0] = true;
		stats.dump[ stats.location -1 ][i][1] = rand(10,200);
		stats.dump[ stats.location -1 ][i][2] = rand(100,150);

		caca_updated = true;

		stats.clean -= 20;

	end

end

/* ------------------------------------------------------------------------- */
/*
	limpia las cacas
*/
function clean_caca( int location )
private
	int i;
end
begin

	for( i=0; i <= 5; i++ )

		// vacio la lista de cacas
		stats.dump[ stats.location -1 ][i][0] = false;
		stats.dump[ stats.location -1 ][i][3] = false;

	end

	stats.clean = 100;

	caca_updated = true;

end


/* ------------------------------------------------------------------------- */
/*
	elimina procesos
*/
function kill_cacas()
private
	int caca_id;
end
begin

	while ( caca_id = get_id(type caca) )
		signal( caca_id, S_KILL );
	end

	//say( "cacas muertas" );

end



/* ------------------------------------------------------------------------- */
process caca(x,y)

begin

	file = fpg_pet;
	graph = 1;

	loop

		frame;

	end

end
