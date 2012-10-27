/* ------------------------------------------------------------------------- */
CONST

	// estados de la mascota
	est_feliz	= 0;
	est_triste	= 1;
	est_muerto	= 2;
	est_cagando	= 3;
	est_ducha	= 4;
	est_sucio	= 5;
	
	// ubicacion
	lugar_interior	= 0;
	lugar_exterior	= 1;

END

/* ------------------------------------------------------------------------- */
PROCESS mascota()

PRIVATE

	int estado;
	int lugar;

	int i;
	
	int grafico[AGES][2];
	int grafico_frame;
	
	int direccion;

END

BEGIN
	
	// valores en el fpg
	grafico[AGE_BABY][0] 	= 10;
	grafico[AGE_BABY][1] 	= 11;
	grafico[AGE_CHILD][0] 	= 20;
	grafico[AGE_CHILD][1] 	= 21;
	grafico[AGE_TEEN][0] 	= 30;
	grafico[AGE_TEEN][1] 	= 31;
	grafico[AGE_ADULT][0] 	= 40;
	grafico[AGE_ADULT][1] 	= 41;
	grafico[AGE_OLD][0] 	= 50;
	grafico[AGE_OLD][1] 	= 51;
	
	x = 100;
	y = 160;
	
	file = load_fpg("fpg/pet.fpg");
	graph = grafico[stats.edad][0];
	

	LOOP
	
		i++;
		
		if ( i>20 )
			i=0;
			grafico_frame++;
			graph = grafico[stats.edad][ grafico_frame % 2 ];
		end
		
		if ( i % 2 == 0 )
			if ( direccion )
				x++;
				
				if ( x > 250 )
					direccion = !direccion;
				end
				
			else
				x--;
				
				if ( x < 70 )
					direccion = !direccion;
				end
				
			end
		end
	
		FRAME;
		
	END

END
