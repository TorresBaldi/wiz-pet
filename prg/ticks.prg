/* ------------------------------------------------------------------------- */
PROCESS calcular_ticks( int ticks )


BEGIN

	//say( ticks + " ticks" );

	WHILE ( ticks > 0 )

		ticks--;

		data.ticks++;

		//crezco
		if ( data.ticks % ticks_per_age == 0 )
			data.age = data.ticks / ticks_per_age;
			if ( data.age > AGES ) data.age = AGES; end // limite
		end

		//hambre
		if ( data.fun < 60 )
			data.food -= 0.6;
		else
			data.food -= 0.1;
		end

		//salud
		if ( data.food < 10 )
			data.health -= 0.8;
		elseif ( data.food < 50 )
			data.health -= 0.2;
		elseif ( data.food < 60 )

			// probabilidad de enfermedad
			if ( rand(1,100) > 99 )
				data.health -= 20;
			end

		end
		
		if ( data.health <=0 AND data.status <> STA_DEAD )
		
			// say("se murio!");
			do_action = ACTN_DIE;
			
		end

		// diversion
		data.fun -= rand(1,8) * 0.1;

		// higiene
		data.shower -= 0.6;

		/*
		// hago caca
		if ( rand(0,100) > 98 )
			do_caca();
		end
		*/

		// limites de stats
		if ( data.food > 100 ) data.food = 100;
		elseif ( data.food < 0 ) data.food = 0; end

		if ( data.health > 100 ) data.health = 100;
		elseif ( data.health < 0 ) data.health = 0; end

		if ( data.fun > 100 ) data.fun = 100;
		elseif ( data.fun < 0 ) data.fun = 0; end

		if ( data.clean > 100 ) data.clean = 100;
		elseif ( data.clean < 0 ) data.clean = 0; end

		if ( data.shower > 100 ) data.shower = 100;
		elseif ( data.shower < 0 ) data.shower = 0; end
		
		update_mood();
		
	END

END

function update_mood()

begin
	
	// calculo el estado de animo de la mascota
	IF ( data.status <> STA_DEAD )
	
		data.status = STA_NORMAL;
		if ( data.fun > 85 )
			data.status = STA_HAPPY;
		end
		
		if ( data.food < 40 )
			data.status = STA_HUNGRY;
		end
		if ( data.fun < 40 )
			data.status = STA_SAD;
		end
		if ( data.shower < 40 )
			data.status = STA_DIRTY;
		end
		if ( data.health < 40 )
			data.status = STA_ILL;
		end
		
	END

end
