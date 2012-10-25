/* ------------------------------------------------------------------------- */
TYPE hms

	// tipo de dato hms para guardar tiempos
	int h;
	int m;
	int s;

END

/* ------------------------------------------------------------------------- */
GLOBAL

	// unidad de tiempo del juego
	int tick = 50;

	STRUCT time
	
		int current;
		int last;
		int delta;
		
	END

	STRUCT stats
	
		int hambre = 1000;
		int salud = 900;
		int diversion = 500;
		int higiene = 900;
		int energia = 900;
		
		hms edad;
	
	END

END
