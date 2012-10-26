/* ------------------------------------------------------------------------- */
PROCESS game_loop()

BEGIN

	// inicializacion del juego
	mascota();

	loop
	
		// cada tick
		IF ( timer[0] >= tick )
		
			timer[0] -= tick;
			
			calcular_ticks(1);
		
		END
		
		//debug
		if ( key(_space) )
			calcular_ticks(5);
		end
		
		frame;
	
	end

END

/* ------------------------------------------------------------------------- */
PROCESS calcular_ticks( int ticks )


BEGIN

	say( ticks + " ticks" );

	WHILE ( ticks > 0 )
		
		ticks--;
		
		stats.ticks++;
		
		//crezco
		if ( stats.ticks % 10 == 0 )
			stats.edad = stats.ticks / 10;
			if ( stats.edad > AGES-1 ) stats.edad = AGES-1; end // limite
		end
		
		//hambre
		if ( stats.diversion > 500 )
			stats.hambre -= 10;
		else
			stats.hambre -= 5;
		end
		
		//salud 
		if ( stats.hambre < 100 )
			stats.salud -= 10;
		elseif ( stats.hambre < 300 )
			stats.salud -= 5;
		else
		
			// probabilidad de enfermedad
			if ( rand(1,100) > 95 )
				stats.salud -= 200;
			end
		
		end
		
		// diversion
		stats.diversion -= rand(0,5);
		
		// higiene
		stats.higiene -= 2;
		
		// energia
		stats.energia -= 2;
		
		// limites
		if ( stats.hambre > 1000 ) stats.hambre = 1000;
		elseif ( stats.hambre < 0 ) stats.hambre = 0; end
		
		if ( stats.salud > 1000 ) stats.salud = 1000;
		elseif ( stats.salud < 0 ) stats.salud = 0; end
	
		if ( stats.diversion > 1000 ) stats.diversion = 1000;
		elseif ( stats.diversion < 0 ) stats.diversion = 0; end
	
		if ( stats.higiene > 1000 ) stats.higiene = 1000;
		elseif ( stats.higiene < 0 ) stats.higiene = 0; end
	
		if ( stats.energia > 1000 ) stats.energia = 1000;
		elseif ( stats.energia < 0 ) stats.energia = 0; end
		
	END

END
