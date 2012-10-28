/* ------------------------------------------------------------------------- */
CONST

	//edades de la mascota
	AGES = 5;
	AGE_BABY 	= 0;
	AGE_CHILD	= 1;
	AGE_TEEN	= 2;
	AGE_ADULT	= 3;
	AGE_OLD		= 4;
	
	// acciones disponibles
	ACTN_FOOD = 1;
	ACTN_PLAY = 2;
	ACTN_MOVE = 3;

END

/* ------------------------------------------------------------------------- */
GLOBAL

	// unidad de tiempo del juego
	int tick = 3;	// un tick cada 3 segundos
	int ticks_per_age = 50;
	
	// manejo de teclado
	int global_key_lock;
	
	//iniciar acciones
	int do_action;
	int action_transition;
	
	STRUCT stats
	
		float hambre = 100;
		float salud = 100;
		float diversion = 100;
		float higiene = 100;
		float energia = 100;
		
		int ticks;
		int edad;
		
		int estado;
		int lugar = 1;
		
		int first_time;
		int last_time;
	
	END
	
	// recursos
	int fpg_bg;

END
