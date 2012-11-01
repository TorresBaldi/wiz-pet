/* ------------------------------------------------------------------------- */
function string s_to_string( int s );

private

	int d,h,m;
	
	string ret;

end

begin

	// descompongo la edad
	while ( s > 60 );
		m++;
		s -= 60;
	end
	
	while( m > 60 );
		h++;
		m -= 60;
	end
	
	while( h > 24 );
		d++;
		h -= 24;
	end
	
	//devuelvo valor
	ret = s + "s";
	if ( m > 0 ) ret = m + "m " + ret; end
	if ( h > 0 ) ret = h + "h " + ret; end
	if ( d > 0 ) ret = d + "d " + ret; end
	
	return ret;

end

/* ------------------------------------------------------------------------- */
function action_info()

private

	string age;
	
	int txt_id;

end

begin
	
	fpg_info = load_fpg( "fpg/info.fpg" );

	say("info!");
	
	put_screen( fpg_info, 10 );
	
	put( 0, draw_bar(data.food,		110, 14), 150, 105 );
	put( 0, draw_bar(data.health,	110, 14), 150, 125 );
	put( 0, draw_bar(data.fun,		110, 14), 150, 145 );
	put( 0, draw_bar(data.clean,	110, 14), 150, 165 );
	put( 0, draw_bar(data.shower,	110, 14), 150, 185 );
	
	age = s_to_string( time() - data.first_time );
	
	txt_id = write_string( 0, 100, 205, 3, &age );
	
	while ( x < 200 )
	
		//age = ftime( "%jD %Hh %Mm %Ss", time() - data.first_time );
		age = s_to_string( time() - data.first_time );
		x++;
		
		frame;
	end
	
onexit

	unload_fpg( fpg_info );
	delete_text( txt_id );

end
