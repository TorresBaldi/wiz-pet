/* ------------------------------------------------------------------------- */
PROCESS mascota()

PRIVATE

	int i;
	int j;

	int grafico[AGES][2];
	int grafico_frame;

	int direccion;
	
	int txt_id;
	
	string string_status;

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
	
	txt_id = write(0, x, y-20, 4, "STATUS: " + stats.status );

	LOOP
	
		if ( stats.status <> STA_DEAD )

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
		
		end
		
		delete_text( txt_id );
		switch ( stats.status )
			case STA_NORMAL:	string_status = "NORMAL"; end 		
			case STA_HAPPY:		string_status = "HAPPY"; end 		
			case STA_SAD:		string_status = "SAD"; end 		
			case STA_HUNGRY:	string_status = "HUNGRY"; end 		
			case STA_DIRTY:		string_status = "DIRTY"; end 		
			case STA_ILL:		string_status = "ILL"; end 		
			case STA_DEAD:		string_status = "DEAD"; end 		
		end
		
		txt_id = write(0, x, y-20, 4, string_status );

		FRAME;
		

	END

END
