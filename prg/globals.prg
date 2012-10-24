TYPE hms

	// tipo de dato hms para guardar tiempos
	int h;
	int m;
	int s;

END

GLOBAL

	STRUCT time
	
		int current;
		int last;
		int delta;
		
	END

	STRUCT stats
	
		int hambre;
		int salud;
		int diversion;
		int edad;
	
	END

END
