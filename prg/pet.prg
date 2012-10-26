/* ------------------------------------------------------------------------- */
PROCESS mascota()

PRIVATE

	int png[2];
	int i;
	int png_frame;
	
	int direccion;

END

BEGIN

	png[0] = load_png("png-sources/baby_1.png");
	png[1] = load_png("png-sources/baby_2.png");
	
	x = 100;
	y = 100;
	
	graph = png[0];

	LOOP
	
		i++;
		
		if ( i>20 )
			i=0;
			png_frame++;
			graph = png[ png_frame % 2 ];
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
