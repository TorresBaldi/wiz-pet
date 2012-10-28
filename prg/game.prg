/* ------------------------------------------------------------------------- */
PROCESS game_loop()

PRIVATE

	int busy = false;

END

BEGIN

	// el proceso no se duerme a si mismo
	signal_action( S_SLEEP_TREE, S_IGN);

	// inicializacion del juego
	mostrar_hud();
	mascota();
	botones();
	actions_manager();
	
	loop
	
		// cada tick
		if ( !busy )
			IF ( timer[0] >= tick * 100 )
			
				timer[0] -= tick * 100;
				
				calcular_ticks(1);
			
			END
			
			//debug
			if ( jkeys_state[ _JKEY_R ] )
				calcular_ticks(1);
			end
			if ( jkeys_state[ _JKEY_L ] )
				reset();
			end
		end
		

		// al activar una accion, duermo el juego
		if ( do_action AND !busy )
		
			busy++;
			
			signal(id, S_SLEEP_TREE );
			
		end
		
		// reactivo el juego al terminar la accion
		if ( busy AND !do_action )
		
			busy = 0;
			signal ( id, S_WAKEUP_TREE );
			
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

//debug
function reset()

begin

	stats.hambre = 100;
	stats.salud = 100;
	stats.diversion = 100;
	stats.higiene = 100;
	stats.energia = 100;
	
	stats.ticks = 0;
	stats.edad = 0;
	
	stats.first_time = time();
	stats.last_time = time();
	
	timer[0] = tick;
	
	while( jkeys_state[ _JKEY_L ] )
		frame;
	end

end
