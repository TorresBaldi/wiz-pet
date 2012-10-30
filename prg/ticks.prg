/* ------------------------------------------------------------------------- */
PROCESS calcular_ticks( int ticks )


BEGIN

	//say( ticks + " ticks" );

	WHILE ( ticks > 0 )

		ticks--;

		stats.ticks++;

		//crezco
		if ( stats.ticks % ticks_per_age == 0 )
			stats.age = stats.ticks / ticks_per_age;
			if ( stats.age > AGES-1 ) stats.age = AGES-1; end // limite
		end

		//hambre
		if ( stats.fun < 50 )
			stats.food -= 0.6;
		else
			stats.food -= 0.1;
		end

		//salud
		if ( stats.food < 10 )
			stats.health -= 0.8;
		elseif ( stats.food < 50 )
			stats.health -= 0.2;
		elseif ( stats.food < 60 )

			// probabilidad de enfermedad
			if ( rand(1,100) > 99 )
				stats.health -= 20;
			end

		end
		if ( stats.health <=0 )
			do_action = ACTN_DIE;
		end

		// diversion
		stats.fun -= rand(1,8) * 0.1;

		// higiene
		stats.shower -= 0.4;

		// energia
		stats.sleep -= 0.6;

		// hago caca
		if ( rand(0,100) > 98 )
			do_caca();
		end

		// limites de stats
		if ( stats.food > 100 ) stats.food = 100;
		elseif ( stats.food < 0 ) stats.food = 0; end

		if ( stats.health > 100 ) stats.health = 100;
		elseif ( stats.health < 0 ) stats.health = 0; end

		if ( stats.fun > 100 ) stats.fun = 100;
		elseif ( stats.fun < 0 ) stats.fun = 0; end

		if ( stats.clean > 100 ) stats.clean = 100;
		elseif ( stats.clean < 0 ) stats.clean = 0; end

		if ( stats.shower > 100 ) stats.shower = 100;
		elseif ( stats.shower < 0 ) stats.shower = 0; end

		if ( stats.sleep > 100 ) stats.sleep = 100;
		elseif ( stats.sleep < 0 ) stats.sleep = 0; end
		
		update_mood();
		
	END

END

function update_mood()

begin
	
	// calculo el estado de animo de la mascota
	stats.status = STA_NORMAL;
	if ( stats.fun > 75 )
		stats.status = STA_HAPPY;
	end
	
	if ( stats.food < 25 )
		stats.status = STA_HUNGRY;
	end
	if ( stats.fun < 25 )
		stats.status = STA_SAD;
	end
	if ( stats.clean < 25 OR stats.shower < 25 )
		stats.status = STA_DIRTY;
	end
	if ( stats.health < 25 )
		stats.status = STA_ILL;
	end
	

end
