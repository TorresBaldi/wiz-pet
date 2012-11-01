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
			l = data.location - 1;

			//say( "ACTUALIZO CACAS LOCATION: " + l );

			//elimino todas las cacas
			while ( caca_id = get_id(type caca) )
				//say("HAY CACA!");
				signal( caca_id, S_KILL );
			end

			//recorro la lista de cacas
			for ( i=0; i <= 5; i++ )

				// si se hizo caca
				if ( data.dump[l][i][0] )

					x = data.dump[l][i][1];
					y = data.dump[l][i][2];

					// si no fue creada la crea
					if ( !data.dump[l][i][3] )

						// creo [id] = caca( [x],[y] )
						data.dump[l][i][3] = caca( x, y);
						//say("creo caca nueva en " + x + "," + y);

					end

					// si no existe el proceso que figura
					if ( !exists(data.dump[l][i][3]) )

						data.dump[l][i][3] = caca( x, y);
						//say("creo caca muerta en " + x + "," + y);
						//say( data.dump[l][i][3].reserved.process_type );

					end

				// si la caca fue limpiada
				elseif ( !data.dump[l][i][0] AND data.dump[l][i][3] )

					// elimino la caca
					if ( exists(data.dump[l][i][3]) )
						signal( data.dump[l][i][3], S_KILL );
						data.dump[l][i][3] = 0;
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
function do_caca(x,y)

private
	int i;
end

begin

	// busco un lugar vacio
	for( i=0; i <= 5; i++ )

		if ( data.dump[ data.location -1 ][i][0] == false )
			break;
		end

	end

	// si hay lugar vacio
	if ( i <= 5 )

		// creo la caca
		data.dump[ data.location -1 ][i][0] = true;
		
		data.dump[ data.location -1 ][i][1] = x;
		data.dump[ data.location -1 ][i][2] = y;

		caca_updated = true;

		data.clean -= 20;
		data.food -= 25;

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
		data.dump[ data.location -1 ][i][0] = false;
		data.dump[ data.location -1 ][i][3] = false;

	end

	data.clean = 100;

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

private
	i;
end

begin

	file = fpg_pet;
	graph = 10;

	loop
	
		i++;
		
		if ( i > 10 )
			i=0;
			if ( graph == 10 )
				graph = 11;
			else
				graph = 10;
			end
		end

		frame;

	end

end
