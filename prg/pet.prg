/* ------------------------------------------------------------------------- */
PROCESS mascota()

PRIVATE

	int i;
	int j;
	
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
	y = 120;
	
	file = fpg_pet;
	graph = grafico[stats.age][0];
	

	LOOP
	
		i++;
		
		if ( i>20 )
			i=0;
			grafico_frame++;
			graph = grafico[stats.age][ grafico_frame % 2 ];
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
