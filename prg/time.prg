/* ------------------------------------------------------------------------- */
FUNCTION string hms_a_string ( hms t )

BEGIN

	return t.h + "h " + t.m + "m " + t.s + "s";
	
END

/* ------------------------------------------------------------------------- */
FUNCTION int hms_a_seg( hms t )

PRIVATE
	int s;
END

BEGIN

	// convierto
	s = (t.h * 3600) + (t.m * 60) + t.s;
	
	// muestro resultado
	//say( "hms_a_seg (" + hms_a_string(t) + "):");	
	//say (s);
	
	// devuelvo resultado
	return s;

END

/* ------------------------------------------------------------------------- */
FUNCTION hms seg_a_hms( int s )

PRIVATE
	hms t;
END

BEGIN

	// convierto
	t.s = s;

	while ( t.s > 60 )
		t.s -= 60;
		t.m += 1;
	end
	while ( t.m > 60 )
		t.m -= 60;
		t.h += 1;
	end
	
	// muestro resultado
	//say( "seg_a_hms (" + s + "):");
	//say ( hms_a_string( t ) );
	
	// devuelvo resultado
	return t;

END
