/* ------------------------------------------------------------------------- */
CONST

	//edades de la mascota
	AGES = 5;
	AGE_BABY 	= 0;
	AGE_CHILD	= 1;
	AGE_TEEN	= 2;
	AGE_ADULT	= 3;
	AGE_OLD		= 4;

	// ubicaciones de la mascota
	LOC_INSIDE	= 1;
	LOC_OUTSIDE	= 2;
	
	// estados de la mascota
	STA_NORMAL	= 0;
	STA_HAPPY	= 1;
	STA_SAD		= 2;
	STA_DIRTY	= 3;
	STA_ILL		= 4;
	STA_DEAD	= 5;

	// acciones disponibles
	ACTN_FOOD	= 1;
	ACTN_PLAY	= 2;
	ACTN_MOVE	= 3;
	ACTN_HEAL	= 4;
	ACTN_CLEAN	= 5;
	ACTN_SLEEP	= 6;
	ACTN_SHOWER	= 7;
	ACTN_DIE	= 8;

	// botones disponibles
	BTN_FOOD	= 0;
	BTN_PLAY	= 1;
	BTN_HEAL	= 2;
	BTN_CLEAN	= 3;
	BTN_SHOWER	= 4;
	BTN_SLEEP	= 5;
	BTN_MOVE	= 6;

	BTN_COUNT = 7;	// cantidad de botones

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

	int caca_updated = true;

	STRUCT stats

		// stats de la criatura
		float food 		= 100;
		float health 	= 100;
		float fun 		= 100;
		float clean 	= 100;
		float shower 	= 100;
		float sleep 	= 100;

		int dump[1][5][3];
		// [1] ubicacion de la caca ( LOC_XXX -1 )
		// [][5] cantidad de cacas (0-5 = 6)
		// [][][0] flag si existe
		// [][][1] posicion x
		// [][][2] posicion y
		// [][][3] id del proceso

		// vida
		int ticks;
		int age;
		
		// estado de la mascota
		int status;

		int location = LOC_INSIDE;

		// fechas
		int first_time;
		int last_time;
		int death_time;

	END

	// recursos
	int fpg_bg;
	int fpg_food;
	int fpg_pet;
	int fpg_system;
	int fpg_tateti;
	int fpg_health;

END
