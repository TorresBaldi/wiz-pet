/* ------------------------------------------------------------------------- */
PROCESS mascota()

PRIVATE

	int i;
	int j;

	int grafico_frame;

	int direccion;
	
	int txt_id;
	
	string string_status;

END

BEGIN

	x = 100;
	y = 130;

	file = fpg_pet;
	
	graph = (stats.age * 100) + (stats.status * 10);
	
	txt_id = write(0, x, y-20, 4, "STATUS: " + stats.status );

	LOOP
	
		if ( stats.status <> STA_DEAD )

			i++;

			if ( i>20 )
			
				i=0;
				grafico_frame++;
				
				graph = (stats.age * 100) + (stats.status * 10);
				
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
			
		else
		
			graph = (stats.age * 100) + (stats.status * 10);
		
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
		
		txt_id = write(0, x, y-40, 4, string_status );

		FRAME;
		

	END

END
