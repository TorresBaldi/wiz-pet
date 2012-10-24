import "mod_map";
import "mod_proc";
import "mod_grproc";
import "mod_key";
import "mod_rand";
import "mod_screen";
import "mod_video";
import "mod_text";
import "mod_time";
import "mod_wm";
import "mod_debug";
import "mod_mouse";

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

GLOBAL

	STRUCT stats
	
		int hambre;
		int salud;
		int diversion;
		int edad;
	
	END

END

/* ------------------------------------------------------------------------- */


BEGIN

	set_title("WizPet");
	scale_resolution = (SCREEN_X * SCREEN_SCALE) * 10000 + (SCREEN_Y * SCREEN_SCALE);
	set_mode(SCREEN_X, SCREEN_Y, SCREEN_D, SCREEN_MODE);
	set_fps(SCREEN_FPS,2);
	
	write_var(0,0,0,0,fps);

	LOOP

		IF ( EXIT_STATUS OR KEY(_ESC) )
			exit();
		END

		frame;

	END


END
