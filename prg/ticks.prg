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
		if ( stats.diversion < 50 )
			stats.hambre -= 0.6;
		else
			stats.hambre -= 0.1;
		end
		
		//salud 
		if ( stats.hambre < 10 )
			stats.salud -= 0.8;
		elseif ( stats.hambre < 50 )
			stats.salud -= 0.2;
		elseif ( stats.hambre < 60 )
		
			// probabilidad de enfermedad
			if ( rand(1,100) > 99 )
				stats.salud -= 20;
			end
		
		end
		
		// diversion
		stats.diversion -= rand(1,8) * 0.1;
		
		// higiene
		stats.higiene -= 0.4;
		
		// energia
		stats.energia -= 0.6;
		
		// limites de stats
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
