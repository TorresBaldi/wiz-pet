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
	
	// 
	int last_time;
	int time_delta;

	STRUCT stats
	
		int hambre = 1000;
		int salud = 900;
		int diversion = 500;
		int higiene = 900;
		int energia = 900;
		
		int ticks;
		int edad;
	
	END

END
