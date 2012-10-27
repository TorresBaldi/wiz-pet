/* ------------------------------------------------------------------------- */
CONST

	//edades de la mascota
	AGES = 5;
	AGE_BABY 	= 0;
	AGE_CHILD	= 1;
	AGE_TEEN	= 2;
	AGE_ADULT	= 3;
	AGE_OLD		= 4;

END
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
	int tick = 100;
	int ticks_per_age = 50;
	
	STRUCT stats
	
		int hambre = 1000;
		int salud = 1000;
		int diversion = 1000;
		int higiene = 1000;
		int energia = 1000;
		
		int ticks;
		int edad;
		
		int estado;
		int lugar;
		
		int last_time;
	
	END

END
