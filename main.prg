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
	
	SCREEN_MODE = MODE_WINDOW;	// modo de pantalla

END

/* ------------------------------------------------------------------------- */

include "prg/globals.prg";

include "prg/time.prg";
include "prg/hud.prg";

/* ------------------------------------------------------------------------- */


BEGIN

	set_title("WizPet");
	scale_resolution = (SCREEN_X * SCREEN_SCALE) * 10000 + (SCREEN_Y * SCREEN_SCALE);
	set_mode(SCREEN_X, SCREEN_Y, SCREEN_D, SCREEN_MODE);
	set_fps(SCREEN_FPS,2);
	
	// test
	say ( hms_a_seg( seg_a_hms( 199 ) ) );
	
	// mostrar hud
	mostrar_hud();

	LOOP

		IF ( EXIT_STATUS OR KEY(_ESC) )
		
			exit();
			
		END
		
		// cada tick
		if ( timer[0] > tick )
		
			timer[0] -= tick;
			
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
			
			stats.diversion -= 5;
			stats.higiene -= 1;
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
		
		end
		

		frame;

	END


END
