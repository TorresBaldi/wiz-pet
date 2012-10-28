import "mod_map";
import "mod_proc";
import "mod_grproc";
import "mod_key";
import "mod_rand";
import "mod_screen";
import "mod_video";
import "mod_text";
import "mod_time";
import "mod_timers";
import "mod_wm";
import "mod_file";
import "mod_debug";
import "mod_say";

/* ------------------------------------------------------------------------- */

CONST

	// parametros de video
	SCREEN_X = 320;	// resolucion x
	SCREEN_Y = 240;	// resolucion y
	SCREEN_D = 16;	// profundidad de color

	SCREEN_SCALE = 2;	// escalado de pantalla (2x, 3x)
	
	SCREEN_FPS	= 60;	// frames
	SCREEN_SKIP	= 0;	// frameskip
	
	SCREEN_MODE = MODE_WINDOW + WAITVSYNC;	// modo de pantalla

END

/* ------------------------------------------------------------------------- */

GLOBAL

	time_delta;

END

/* ------------------------------------------------------------------------- */

include "prg/jkeys.prg";

include "prg/globals.prg";

include "prg/gui.prg";
include "prg/hud.prg";
include "prg/actions.prg";
include "prg/game.prg";
include "prg/pet.prg";

/* ------------------------------------------------------------------------- */


BEGIN

	// inicializo video dependiendo el OS
	switch ( OS_ID )
	
		case OS_GP2X_WIZ:

			set_mode(320, 240, 16, MODE_FULLSCREEN + WAITVSYNC);
			set_fps(SCREEN_FPS,2);		
		
		end
		
		default:

			set_title("WizPet");
			scale_resolution = (SCREEN_X * SCREEN_SCALE) * 10000 + (SCREEN_Y * SCREEN_SCALE);
			set_mode(SCREEN_X, SCREEN_Y, SCREEN_D, SCREEN_MODE);
			set_fps(SCREEN_FPS,2);
	
		end
	
	end
	
	// inicializacion de teclas
	jkeys_set_default_keys();
	jkeys_init();
	
	//cargo tiempo anterior
	if ( fexists("time.dat") )
		load( "time.dat", stats );
	else
		stats.first_time = time();
		stats.last_time = time();
	end
	
	// calculo el tiempo que paso
	time_delta = time() - stats.last_time;
	
	// modifico los stats
	calcular_ticks ( time_delta / tick );
	
	// inicio el bucle del juego
	game_loop();

	LOOP

		IF ( EXIT_STATUS OR jkeys_state[ _JKEY_MENU ] )
			
			stats.last_time = time();
			
			save( "time.dat", stats );
		
			exit();
			
		END		

		frame;

	END


END
