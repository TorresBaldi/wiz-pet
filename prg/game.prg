/* ------------------------------------------------------------------------- */
PROCESS game_loop()

BEGIN

	// inicializacion del juego
	mascota();
	
	botones();
	
	actions_manager();
	
	put( load_fpg("fpg/bg.fpg"), stats.lugar+1, screen_x/2, screen_y/2 );

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

	//say( ticks + " ticks" );

	WHILE ( ticks > 0 )
		
		ticks--;
		
		stats.ticks++;
		
		//crezco
		if ( stats.ticks % ticks_per_age == 0 )
			stats.edad = stats.ticks / ticks_per_age;
			if ( stats.edad > AGES-1 ) stats.edad = AGES-1; end // limite
		end
		
		//hambre
		if ( stats.diversion > 50 )
			stats.hambre -= 1;
		else
			stats.hambre -= 0.5;
		end
		
		//salud 
		if ( stats.hambre < 10 )
			stats.salud -= 1;
		elseif ( stats.hambre < 30 )
			stats.salud -= 5;
		else
		
			// probabilidad de enfermedad
			if ( rand(1,100) > 98 )
				stats.salud -= 20;
			end
		
		end
		
		// diversion
		stats.diversion -= rand(0,5);
		
		// higiene
		stats.higiene -= 0.2;
		
		// energia
		stats.energia -= 0.2;
		
		// limites
		if ( stats.hambre > 100 ) stats.hambre = 100;
		elseif ( stats.hambre < 0 ) stats.hambre = 0; end
		
		if ( stats.salud > 100 ) stats.salud = 100;
		elseif ( stats.salud < 0 ) stats.salud = 0; end
	
		if ( stats.diversion > 100 ) stats.diversion = 100;
		elseif ( stats.diversion < 0 ) stats.diversion = 0; end
	
		if ( stats.higiene > 100 ) stats.higiene = 100;
		elseif ( stats.higiene < 0 ) stats.higiene = 0; end
	
		if ( stats.energia > 100 ) stats.energia = 100;
		elseif ( stats.energia < 0 ) stats.energia = 0; end
		
	END

END
