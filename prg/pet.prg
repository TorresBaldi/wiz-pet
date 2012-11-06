/* ------------------------------------------------------------------------- */
PROCESS mascota()

PRIVATE

	int i;
	int j;

	int grafico_frame;
	
	int txt_id;
	
	int next_caca;
	
	int pensamiento_id;
	
	string string_status;
	
	int min_x = 50;
	int max_x = 260;
	
	int min_y = 160;
	int max_y = 190;
	
	int final_x;
	int final_y;
	
	int dist_x;
	int dist_y;
	
	float fx;
	float fy;
	
	float vx;
	float vy;

END

BEGIN

	x = 100;
	y = 180;

	file = fpg_pet;
	
	graph = 100 + (data.age * 100) + (data.status * 10);
	
	next_caca = rand (200, 2000);
	
	//txt_id = write(0, x, y-20, 4, "STATUS: " + data.status );
	
	fx = final_x = rand( min_x, max_x );
	fy = final_y = rand( min_y, max_y );
	
	//say( "pos: " + x + "," + y );

	LOOP
	
		if ( data.status <> STA_DEAD )
		
			//say("no esta muerto. entro al bucle");
			
			dist_x = (final_x - x);
			dist_y = (final_y - y);
			
			//say("calculo distancia");
			
			// movimiento
			if ( abs(dist_x) < 2 AND abs(dist_y) < 2)	// elijo nueva posicion
			
				//say("entro a elegir nueva posicion");
			
				final_x = rand( min_x, max_x );
				final_y = rand( min_y, max_y );
				
				dist_x = (final_x - x);
				dist_y = (final_y - y);
				
				//say("...");
				
				if ( abs(dist_x) > abs(dist_y) )
				
					//say("entro primer if");
				
					vy = ( (final_y - y) / abs(final_x - x) ) / 2;
					if ( dist_x > 0) vx = 0.5; else vx = -0.5; end
				
				else
				
					//say("entro segundo if");
				
					vx = ( (final_x - x) / abs(final_y - y) ) / 2;
					if ( dist_y > 0) vy = 0.5; else vy = -0.5; end
				
				end
				
				//say("supero if");
				
				/*
				say( "dist:" + dist_x + "," + dist_y );
				say( "vel:" + vx + "," + vy );
				draw_line( x,y, x+dist_x, y+dist_y );
				*/
				
			else
			
				//say("actualizo posicion float...");
			
				fx += vx;
				fy += vy;
				
			end
			
			//say("actualizo posicion...");
			
			x = fx;
			y = fy;
			z = -100 - y;

			// animacion
			i++;
			if ( i>20 )
			
				i=0;
				grafico_frame++;
				graph = 100 + (data.age * 100) + (data.status * 10) + grafico_frame%2;
				
			end			
			
			// hago caca
			next_caca--;
			if ( next_caca == 0 )
			
				next_caca = rand (300, 2500);
				do_caca(x,y);
				
			end
			//say( next_caca );
			
		else
		
			graph = 100 + (data.age * 100) + (data.status * 10);
		
		end

		
		if ( data.status == STA_HUNGRY )
		
			if ( !exists(pensamiento_id) )
			
				pensamiento_id = pensamiento( rand(1,6)*10 + 1 );
			
			else
			
				pensamiento_id.x = x + 30;
				pensamiento_id.y = y - 80;
				
			end
			
		else
		
			if ( pensamiento_id )
				signal(pensamiento_id, S_KILL);
			end
		
		end

		FRAME;
		

	END

END

process pensamiento( graph )

begin

	file = load_fpg( "fpg/food.fpg" );
	
	loop
	
		frame;
		
	end
onexit
	unload_fpg( file );
end
