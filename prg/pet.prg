/* ------------------------------------------------------------------------- */
PROCESS mascota()

PRIVATE

	int i;
	int j;

	int grafico_frame;

	int direccion;
	
	int txt_id;
	
	int next_caca;
	
	string string_status;

END

BEGIN

	x = 100;
	y = 180;
	z = -200;

	file = fpg_pet;
	
	graph = (data.age * 100) + (data.status * 10);
	
	next_caca = rand (50, 2500);
	
	//txt_id = write(0, x, y-20, 4, "STATUS: " + data.status );

	LOOP
	
		if ( data.status <> STA_DEAD )

			i++;

			if ( i>20 )
			
				i=0;
				
				grafico_frame++;
				
				graph = (data.age * 100) + (data.status * 10) + grafico_frame%2;
				
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
			
			// hago caca
			next_caca--;
			if ( next_caca == 0 )
			
				next_caca = rand (300, 2500);
				do_caca(x,y);
				
			end
			//say( next_caca );
			
		else
		
			graph = (data.age * 100) + (data.status * 10);
		
		end
		
		/*
		delete_text( txt_id );
		switch ( data.status )
			case STA_NORMAL:	string_status = "NORMAL"; end 		
			case STA_HAPPY:		string_status = "HAPPY"; end 		
			case STA_SAD:		string_status = "SAD"; end 		
			case STA_HUNGRY:	string_status = "HUNGRY"; end 		
			case STA_DIRTY:		string_status = "DIRTY"; end 		
			case STA_ILL:		string_status = "ILL"; end 		
			case STA_DEAD:		string_status = "DEAD"; end 		
		end
		
		txt_id = write(0, x, y-40, 4, string_status );
		*/

		FRAME;
		

	END

END
