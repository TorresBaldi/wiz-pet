/* ------------------------------------------------------------------------- */
CONST

	//edades de la mascota
	AGES = 5;
	AGE_BABY 	= 1;
	AGE_CHILD	= 2;
	AGE_TEEN	= 3;
	AGE_ADULT	= 4;
	AGE_OLD		= 5;

	// ubicaciones de la mascota
	LOC_INSIDE	= 2;
	LOC_OUTSIDE	= 1;
	
	// valor de los ticks
	TICK_INGAME	= 0;
	TICK_OLDGAME	= 1;
	
	// estados de la mascota
	STA_NORMAL	= 0;
	STA_HAPPY	= 0;
	STA_HUNGRY	= 4;
	STA_SAD		= 1;
	STA_DIRTY	= 3;
	STA_ILL		= 2;
	STA_DEAD	= 5;

	// acciones disponibles
	ACTN_FOOD	= 1;
	ACTN_PLAY	= 2;
	ACTN_MOVE	= 3;
	ACTN_HEAL	= 4;
	ACTN_CLEAN	= 5;
	ACTN_BATH	= 6;
	ACTN_DIE	= 7;
	ACTN_INFO	= 8;
	
	// alertas disponibles
	ALE_GOOD	= 80;
	ALE_BAD		= 90;
	ALE_NOTBAD	= 50;
	ALE_GOINSIDE	= 70;
	ALE_NOTNEED	= 60;
	ALE_CLEAN	= 40;
	ALE_RIP		= 30;

	// botones disponibles
	BTN_FOOD	= 0;
	BTN_PLAY	= 1;
	BTN_HEAL	= 2;
	BTN_CLEAN	= 3;
	BTN_BATH	= 4;
	BTN_MOVE	= 6;
	BTN_INFO	= 5;

	BTN_COUNT = 7;	// cantidad de botones
	
	// opciones del menu principal
	MENU_CONTINUE	= 0;
	MENU_START	= 1;
	MENU_GRAVEYARD	= 2;
	MENU_CREDITS	= 3;
	MENU_OPTIONS	= 4;
	MENU_EXIT	= 5;
	
	MENU_COUNT = 6;
	
	GRAVEYARD_COUNT = 20;
	
	TICKS_PER_DAY = 280000;

END

/* ------------------------------------------------------------------------- */
GLOBAL

	// unidad de tiempo del juego
	int tick = 3;	// un tick cada 3 segundos

	// manejo de teclado
	int global_key_lock;

	//iniciar acciones
	int do_action;

	int caca_updated = true;
	
	// indica si la partida fue iniciada
	int game_started;
	
	int open_main_menu = true;
	int menu_avaliable[ MENU_COUNT-1 ];
	
	int current_volume;
	
	int wiz;
	int transition_speed;
	
	int age_duration[AGES];

	STRUCT data
	
		string name;

		// stats de la criatura
		float food;
		float health;
		float fun;
		float clean;
		float shower;

		int dump[1][5][3];
		// [1] ubicacion de la caca ( LOC_XXX -1 )
		// [][5] cantidad de cacas (0-5 = 6)
		// [][][0] flag si existe
		// [][][1] posicion x
		// [][][2] posicion y
		// [][][3] id del proceso

		// vida
		int ticks;
		int age = AGE_BABY;
		
		// estado de la mascota
		int status;

		int location = LOC_INSIDE;

		// fechas
		int first_time;
		int last_time;
		int death_time;
		
		// opciones
		int volume = 80; // porcentaje de volumen
		
		// cementerio
		struct graveyard[ GRAVEYARD_COUNT ];
		
			string name;
			int age;
			
			int first_time;
			int death_time;
		end

	END

	// recursos
	int fpg_bg;
	int fpg_food;
	int fpg_pet;
	int fpg_system;
	int fpg_hud;
	int fpg_menu;
	int fpg_info;
	int fpg_tateti;
	int fpg_health;
	int fpg_shower;
	
	int fnt_nueva_18;
	
	int ogg_dst_dreamingreen;

END
